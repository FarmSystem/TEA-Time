import React from "react";
import { Text, StyleSheet, View, TouchableOpacity } from 'react-native';
import styled, {ThemeProvider} from "styled-components/native";
import { theme } from "../theme";


const Container = styled.View`
  flex: 1;
  justify-content: center;
  align-items: center;
  background-color: #fff9f2;
`;

const Savebutton = styled.TouchableOpacity`
background-color : #677a46;
border-radius : 20px;
width :120px;
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
width : 350px;
margin : 3px 0;
padding : 15px 20px;
border-radius : 5px;
justify-content: space-around;
background-color : ${({theme}) => theme.itemBackground};
border : 2px solid #D9D9D9;
color : black;
font-size : 17px;
`;

const ImageBox = styled.TouchableOpacity`
width : 350px;
margin : 3px 0;
padding : 15px 20px;
border-radius : 5px;
justify-content: space-around;
background-color : ${({theme}) => theme.itemBackground};
border : 2px solid #D9D9D9;
color : black;
font-size : 16px;
`;

const styles = StyleSheet.create({
  Save: {
    position: "absolute",
    top: -120,
    left: 220,
  },
});

const WritePage = () => {
  return (
    <Container>
      <View>
       <ThemeProvider theme={theme}>
        <View style = {styles.Save}>
          <Savebutton>
            <Title>저장하기</Title>
          </Savebutton>
        </View>
        <StyledInput style = {{position : "absolute", top : -30}}>
          <Text placeholder = "yyyy/mm/dd" placeholderTextColor = "#3498db"/>
        </StyledInput>
        <WriteBox style = {{top : 48, height : 60, fontWeight : 'bold'}}/>
        <WriteBox style = {{top : 40, height : 250, fontSize : 15}}/>
        <ImageBox style = {{top : 55, height : 160}}>
          <Title style = {{color : 'black', fontWeight : 'bold'}}>사진 첨부하기</Title>
        </ImageBox>
       </ThemeProvider>
      </View>
    </Container>
  );
};


export default WritePage;
