import React, {useState} from "react";
import { Text, StyleSheet, View, TouchableOpacity, Switch, ScrollView } from 'react-native';
import styled, {ThemeProvider} from "styled-components/native";
import { theme } from "../theme";
import * as ImagePicker from "expo-image-picker";


const Container = styled.View`
  flex: 1;
  justify-content: center;
  align-items: center;
  background-color: #fff9f2;
`;

const Savebutton = styled.TouchableOpacity`
background-color : #799462;
border-radius : 20px;
width :110px;
padding: 12px;
margin-vertical: 40px;
height : 38px;
justify-content : space-around;
font-size : 20px;
`;

const Title = styled.Text`
font-size : 14px;
font-weight : 400;
color : white;
text-align : center;
align-items : center;
`;

const StyledInput = styled.TextInput`
width : 350px;
height : 50px;
margin : 3px 0;
padding : 15px 20px;
border-radius : 5px;
justify-content: space-around;
background-color : ${({theme}) => theme.itemBackground};
border : 2px solid #D9D9D9;
color : black;
font-size : 20px;
font-weight : bold;
text-align : center;
`;

const WriteBox = styled.TextInput`
width : 280px;
margin : 3px 0;
padding : 15px 20px;
border-radius : 3px;
justify-content: space-around;
background-color : ${({theme}) => theme.itemBackground};
border : 2px solid #D9D9D9;
color : black;
font-size : 17px;
`;

const ImageBox = styled.View`
width : 350px;
margin : 3px 0;
padding : 15px 20px;
border-radius : 3px;
justify-content: space-around;
background-color : ${({theme}) => theme.itemBackground};
border : 2px solid #D9D9D9;
color : black;
font-size : 16px;
`;

const PutImage = styled.TouchableOpacity`
background-color :#cbe3b3;
border-radius : 10px;
width :130px;
padding: 8px;
margin-vertical: 40px;
height : 40px;
justify-content : space-around;
font-size : 14px;
`;

const Emoji = styled.TouchableOpacity`
width : 73px;
height : 60px;
margin : 3px 0;
padding : 15px 20px;
border-radius : 3px;
justify-content: space-around;
background-color : ${({theme}) => theme.itemBackground};
border : 2px solid #D9D9D9;
color : black;
`;

const EmojiContainer = styled.View`
background-color : #a9d1b1;
border-radius : 15px;
width :70px;
padding: 12px;
margin-vertical: 40px;
height : 50px;
justify-content : space-around;
font-size : 20px;
`;

const styles = StyleSheet.create({
  Save: {
    position: "absolute",
    top: -120,
    left: 220,
  },
});

const pickImage = async() => {
  console.log('이미지 선택');
  let imageData = await ImagePicker.launchImageLibraryAsync({
    mediaTypes: ImagePicker.MediaTypeOptions.All,
    allowsEditing : true,
    aspect : [4, 4],
    quality : 1,
  });
  console.log('이미지 데이터: ', imageData);
};


//이모티콘 고르는 창...
const pickEmoji = () => {
  return (
    <EmojiContainer>
    </EmojiContainer>
  )
}

const WritePage = () => {

  const [isEnabled, setIsEnabled] = useState(false);
  const toggleSwitch = () => setIsEnabled(previousState => !previousState);

  return (
    <Container>
      <View>
       <ThemeProvider theme={theme}>
        <View style = {styles.Save}>
          <Savebutton>
            <Title>작성하기</Title>
          </Savebutton>
          <Switch style = {{position : "absolute", top : 45, left : -200}}
          trackColor={{false: '#767577', true: '#799462'}}
          thumbColor={isEnabled ? '#ffffff' : '#d4e8b0'} 
          ios_backgroundColor="#3e3e3e"
          onValueChange={toggleSwitch}
          value={isEnabled}
           />
        </View>

        <StyledInput style = {{position : "absolute", top : -30}}/>
        <View style = {{flexDirection : 'row'}}>
          <WriteBox style = {{top : 48, height : 60, fontWeight : 'bold'}}/>
          <Emoji style = {{position : "absolute", left : 277, top : 48}}
           onPress = {pickEmoji}> 
           <Text>😀</Text>
          </Emoji>
        </View>
        <WriteBox multiline={true} style = {{top : 40, height : 250, width : 350, fontSize : 15}}/>
        <ImageBox style = {{top : 55, height : 160}}>
          <PutImage style = {{left : 85}}>
            <Title style = {{color : 'black', fontWeight : 'bold'}}
             onPress={pickImage}>사진 첨부하기</Title>
          </PutImage>
        </ImageBox>

       </ThemeProvider>
      </View>
    </Container>
  );
};


export default WritePage;
