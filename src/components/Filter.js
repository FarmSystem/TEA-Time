import Button from './Button';
import React, {Component} from 'react';
import { StyleSheet, TouchableOpacity, Text, View } from 'react-native';

const styles = StyleSheet.create({
    FilterContainer : {
        width : 70,
        height : 50,
        backgroundColor : 'green',
        flexDirection: 'row',
        alignItems : 'center',
    },

});

const New = () => {
    return (
        <TouchableOpacity
          style = {{
            backgroundColor : 'white',
            padding : 8,
            margin : 5,
            borderRadius : 8,
          }}
          onPress = {() => alert('click!')}
        >
            <Text style = {{color : 'black', fontSize : 10}}>최신순</Text>
        </TouchableOpacity>
    )
}

const Score = () => {
    return (
        <TouchableOpacity
          style = {{
            backgroundColor : 'white',
            padding : 8,
            margin : 5,
            borderRadius : 8,
          }}
          onPress = {() => alert('click!')}
        >
            <Text style = {{color : 'black', fontSize : 10}}>점수순</Text>
        </TouchableOpacity>
    )
}

const Length = () => {
    return (
        <TouchableOpacity
          style = {{
            backgroundColor : 'white',
            padding : 8,
            margin : 5,
            borderRadius : 8,
          }}
          onPress = {() => alert('click!')}
        >
            <Text style = {{color : 'black', fontSize : 10}}>길이순</Text>
        </TouchableOpacity>
    )
}

const Filter = () => {
  return (
    <View style={styles.FilterContainer}>
      <New />
      <Score />
      <Length />
    </View>
  );
};

export default Filter;
