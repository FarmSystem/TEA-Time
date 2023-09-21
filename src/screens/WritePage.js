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
font-size : 22px;
font-weight : bold;
text-align : center;
`;

const styles = StyleSheet.create({
  Save: {
    position: "absolute",
    top: -315,
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
        <StyledInput style = {{top : -210}}>
          <Text placeholder = "yyyy/mm/dd" placeholderTextColor = "#3498db"/>
        </StyledInput>
       </ThemeProvider>
      </View>
    </Container>
  );
};


export default WritePage;
