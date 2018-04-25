import React from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  View,NativeModules, NativeAppEventEmitter
} from 'react-native';

var CalendarManager = NativeModules.CalendarManager;
var nativeAppEv;
class RNTest extends React.Component {
    // 构造
    constructor(props) {
        super(props);
        // 初始状态
        this.state = {
            str:''
        };
    }
  render() {

    return (
      <View style={styles.container}>
          <Text style={styles.welcome1} onPress={()=>this.passValueToNativeOne()}>点击往原生传字符串</Text>
          <Text style={styles.welcome2} onPress={()=>this.passValueToNativeTwo()}>点击向原生传字符串和字典</Text>
          <Text style={styles.welcome1} onPress={()=>this.passValueToNativeThree()}>点击往原生传字符串+日期</Text>
          <Text style={styles.welcome2} onPress={()=>this.callBackOne()}>点击调原生+回调</Text>
          <Text style={styles.welcome1} onPress={()=>this.callBackTwo()}>Promises</Text>
          <Text style={styles.welcome2} onPress={()=>this.useNativeValue()}>使用原生定义的常量</Text>
          <Text style={styles.welcome1}>我是原生传过来的:{this.state.str}</Text>

      </View>
    );
  }
    // 传原生一个字符串
    passValueToNativeOne = ()=>{
        CalendarManager.addEventOne('永超');
    }
    // 传原生一个字符串 + 字典
    passValueToNativeTwo = ()=>{
        CalendarManager.addEventTwo('永超',{job:'iOS'});
    }
   // 传原生一个字符串 + 日期
    passValueToNativeThree = ()=>{
        var myDate = new Date();//获取系统当前时间
        CalendarManager.addEventThree('永超',myDate);
    }

    callBackOne=()=>{
        CalendarManager.testCallbackEventOne(('我是RN给原生的'),(error,event)=>{
            if (error){
                console.error(error);
            }
            else {
                alert(event);
            }

        })
    }
    //Promise回调
    async callBackTwo(){
        try{
            var events=await CalendarManager.testCallbackEventTwo();
            alert(events)
        }catch(e){
            console.error(e);
        }
    }
    //使用原生定义的常量
    useNativeValue = ()=>{
        alert(CalendarManager.ValueOne)
    }

    componentDidMount() {
        CalendarManager.RNCallOC();
        nativeAppEv= NativeAppEventEmitter.addListener(
            'EventReminder',
            (reminder) => {
                this.setState({
                    str:reminder
                })
            }
        );

    }

    componentWillUnmount() {
        nativeAppEv.remove();
    }


}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#FFFFFF',
  },
    welcome1: {
        fontSize: 20,
        textAlign: 'center',
        margin: 10,
    },
    welcome2: {
        fontSize: 20,
        textAlign: 'center',
        margin: 10,
        color:"red"

    },

});

// 整体js模块的名称
AppRegistry.registerComponent('RNAndNative', () => RNTest);
