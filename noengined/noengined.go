package main

// NoEngined 用于控制NoEngine应用启停的程序
// 不支持并发启停所以需要创建一个启动中标识文件

import (
	"encoding/json"
	"flag"
	"fmt"
	"io/ioutil"
	"os"
	"path"
	"sync"
)

const (
	NoEngined = "NoEngined"
	NoEngine = "NoEngine"
	NoEngineFlag = "/tmp/noengine.flag"
)

var AppMap = "apps.json"

func init() {
	appRoot := os.Getenv("APP_ROOT")
	if appRoot != "" {
		AppMap = path.Join(appRoot, NoEngine, AppMap)
	}
}

type NoEngineApp struct {
	Stat string `json:"stat"`
	Domain string `json:"domain"`
}

var lock sync.Mutex

func main()  {
	start := flag.String("start", "", "start an app")
	stop := flag.String("stop", "", "stop an app")
	stat := flag.String("stat", "", "return app stat")
	flag.Parse()

	// parse file
	lock.Lock()
	if _, err := os.Stat(NoEngineFlag); os.IsNotExist(err) {
		f, err := os.Create(NoEngineFlag)
		if err != nil {
			fmt.Println(err)
		}
		err = f.Close()
		if err != nil {
			fmt.Println(err)
			return
		}
		err = os.Remove(NoEngineFlag)
		if err != nil {
			fmt.Println(err)
			return
		}
	} else {
		// 有服务正在启动中
		os.Exit(1)
	}
	defer lock.Unlock()
	if *start != "" {
		err := modifyApp(*start, "run")
		if err != nil {
			fmt.Println(err)
			os.Exit(1)
		}
	}

	if *stop != "" {
		err := modifyApp(*stop, "stop")
		if err != nil {
			fmt.Println(err)
			os.Exit(1)
		}
	}

	if *stat != "" {
		ok := statApp(*stat)
		if !ok {
			os.Exit(1)
		}
	}

	os.Exit(0)
}

func modifyApp(app string, stat string) error {
	data, err := ioutil.ReadFile(AppMap)
	if err != nil {
		fmt.Println(err)
		return err
	}
	var apps map[string]*NoEngineApp
	err = json.Unmarshal(data, &apps)
	if err != nil {
		fmt.Println(err)
		return err
	}
	a, ok := apps[app]
	if !ok {
		return err
	}
	a.Stat = stat
	data, err = json.Marshal(apps)
	if err != nil {
		fmt.Println(err)
		return err
	}
	err = ioutil.WriteFile(AppMap, data, 0644)
	return err
}

func statApp(app string) bool {
	data, err := ioutil.ReadFile(AppMap)
	if err != nil {
		fmt.Println(err)
		return false
	}
	var apps map[string]NoEngineApp
	err = json.Unmarshal(data, &apps)
	if err != nil {
		fmt.Println(err)
		return false
	}
	a, ok := apps[app]
	if !ok {
		return false
	}
	return a.Stat == "run"
}