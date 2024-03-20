import dummy from '../db/data.json';
import {StyleSheet, SafeAreaView, Text} from 'react-native';


export default function List(){
  /*console.log(data);*/

  <SafeAreaView style = {[styles.container]}>
    {dummy.data && dummy.data.map((data) => {
      return (
        <Text style = {styles.text} key = {data.title}>
          {content.title}
        </Text>
      );
    })}
  </SafeAreaView>
  //return <></>;
};

const styles = StyleSheet.create({
  container : {
      width : '100%',
      alignItems : 'center',
      justifyContent : 'center',
      height : 80,
  },
  header : {
      backgroundColor : '#FFF0DD',
      flex : 1,
  },
  contents : {
      flex : 8,
      backgroundColor : '#FFF9F2',
      height : 640,
  },
  footer : {
      backgroundColor : '#EBD7B0',
      flex : 1,
  },
  text : {
      fontSize : 20,
      fontWeight : "bold",
  },
});