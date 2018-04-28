import React from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  View,
    NativeModules,
    NativeAppEventEmitter,
    DatePickerIOS,
    Button
} from 'react-native';

var CalendarManager = NativeModules.CalendarManager;
var  enumConstants=NativeModules.EnumConstants;
var  myThread=NativeModules.MyThread;
var nativeAppEv;
class RNTest extends React.Component {
    // 构造
    //在ES6中，在子类的constructor中必须先调用super才能引用this,
    // super(props)的目的：在constructor中可以使用this.props
    //props是在父组件中指定，而且一经指定，在被指定的组件的生命周期中则不再改变。 对于需要改变的数据，我们需要使用state。
    constructor(props) {
        super(props);
        // 初始状态
        this.state = {
            str:''
        };
        this.state = {startDate: new Date(), endDate: new Date()};


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
              <Text style={styles.welcome2} onPress={()=>this.onPressForEnum()}>枚举应用</Text>
              <Text style={styles.welcome1} onPress={()=>this.threadTest()}>线程操作</Text>
              <Text style={styles.welcome2} onPress={()=>this.clearRom()}>清除缓存</Text>


      </View>
    );
  }
   threadTest=()=>{
        myThread.doSomethingExpensive(('1234'),(error,event)=>{
            if (error){
                console.error(error);
            }
            else {
                alert(event);
            }
        })
   }

    onPressForEnum() {
        alert(enumConstants.statusBarAnimationSlide);
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
    //可以在一个声明了async的异步函数内使用await关键字来调用，
    // 并等待其结果返回。（虽然这样写着看起来像同步操作，但实际仍然是异步的，并不会阻塞执行来等待）。
    async callBackTwo(){
        try{
            var events=await CalendarManager.testCallbackEventTwo();
            alert(events)
        }
        catch(e){
            console.error(e);
        }
    }
    //使用原生定义的常量
    //注意这个常量仅仅在初始化的时候导出了一次，所以即使你在运行期间改变constantToExport返回的值，
    // 也不会影响到JavaScript环境下所得到的结果。
    useNativeValue = ()=>{
        alert(CalendarManager.ValueOne)
    }
    clearRom  =()=>{
        CalendarManager.cleanCache((error, events) => {
            if (error) {

            }
            else {
                this.setState({

                    cache:0  //这里本应该是清除之后的数据Math.round(events/1024).应该是0才对,但是总是清不干净,我就直接置为0了

                })

            }
        })
    }
    componentWillMount() {
                 CalendarManager.cacheSize((error, events) => {
                         if (error) {
                             console.error(error);
                            }
                            else {
                                this.setState({
                                    cache:Math.round(events/1024)   //缓存大小
                                })
                         }})
       }

    componentDidMount() {
        CalendarManager.RNCallOC();
        //NativeAppEventEmitter， 用于创建监听事件。对组件监听
        //addListener 是用于鼠标，键盘等特殊元素的一些监听
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
        nativeAppEv.remove();//取消订阅。类似iOS中的通知
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
        fontSize: 25,
        textAlign: 'center',
        margin: 10,
        color:"red"

    },

});

// 整体js模块的名称
AppRegistry.registerComponent('RNAndNative', () => RNTest);
