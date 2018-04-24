import React from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  View
} from 'react-native';

class RNHighScores extends React.Component {
  render() {

    return (
      <View style={styles.container}>
        <Text >
       hello，我是RN
        </Text>

      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#FFFFFF',
  },

});

// 整体js模块的名称
AppRegistry.registerComponent('RNAndNative', () => RNHighScores);
