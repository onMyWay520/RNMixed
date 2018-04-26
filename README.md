# RNMixed
RN与原生iOS之间的交互
1.RCTBridgeModule
 
 RCTBridgeModule
 在React Native中，如果实现一个原生模块，需要实现RCTBridgeModule”协议，其中RCT就是ReaCT的缩写。
 
 RCT_EXPORT_MODULE()
 如果我们实现了RCTBridgeModule协议，我们的类需要包含RCT_EXPORT_MODULE()宏。这个宏也可以添加一个参数用来指定在Javascript中访问这个模块的名字。如果你不指定，默认就会使用这个Objective-C类的名字。
 
 RCT_EXPORT_METHOD()
 与此同时我们需要声明RCT_EXPORT_METHOD()宏来实现要给Javascript导出的方法，否则React Native不会导出任何方法。
 
 RCT_REMAP_METHOD()
 React Native还定义了一个RCT_REMAP_METHOD()宏，它可以指定Javascript方法名， 当许多方法的第一部分相同的时候用它来避免在Javascript端的名字冲突。
 
 2.NativeModules
 
 在Javascript中如果想调用Native的方法，需要使用RN提供的NativeModules模块，具体代码实例中会给出。
 
 3.NativeAppEventEmitter
 
 这是一个事件监听处理的方法，应用在JS中，可以监听到native调用的事件以及参数
 
