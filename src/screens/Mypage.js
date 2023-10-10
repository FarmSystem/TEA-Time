import React, {useState, useRef, useEffect} from "react";
import { Text, StyleSheet, View, TouchableOpacity, Switch, Image, ScrollView, Button} from 'react-native';
import styled, {ThemeProvider} from "styled-components/native";
import { theme } from "../theme";
import {KeyboardAwareScrollView} from 'react-native-keyboard-aware-scroll-view';
import { Input } from "galio-framework";
import * as Progress from 'react-native-progress';

const Container = styled.View`
  flex: 1;
  justify-content: center;
  align-items: center;
  background-color: #fff9f2;
`;

const ButtonContainer = styled.TouchableOpacity`
background-color : #db7a53;
border-radius : 20px;
padding : 15px 30px;
margin : 10px 0px;
justify-content : center;
`;

const Title = styled.Text`
font-size : 18px;
font-weight : 500;
color : #ffffff;
`;

const Buttons = ({title, onPress}) => {
  return (
    <ButtonContainer onPress = {onPress}>
      <Title>{title}</Title>
    </ButtonContainer>
  );
};

const validateEmail = email => {
    const regex = /^[0-9?A-z0-9?]+(\.)?[0-9?A-z]+\.[A-z]{2}.?[A-z]{0,3}$/;
    return regex.test(email);
};

export const removeWhitespace = text => {
    const regex = /\s/g;
    return text.replace(regex, '');
};

const ErrorText = styled.Text`
align-items : flex-start;
width : 100%;
height : 20px;
margin-bottom : 10px;
line-height : 20px;
color : black;
`;

const StyledImage = styled.Image`
width : 100px;
height : 100px;
border-radius : ${({rounded}) => (rounded ? 50 : 0)}px;
`;


const Mypage = () => {
    const [name, setName] = useState('');
    const [email, setEmail] = useState('');
    const [birthdate, setbirthdate] = useState('');
    const [errorMessage, setErrorMessage] = useState('');
    const [disabled, setDisabled] = useState(true);

    const emailRef = useRef();
    const birthdateRef = useRef();
    const [isEnabled, setIsEnabled] = useState(false);
    const toggleSwitch = () => setIsEnabled(previousState => !previousState);

    useEffect(()=> {
        let _errorMessage = '';
        if (!name){
            _errorMessage = 'please enter your name.';
        }
        else {
            _errorMessage = '';
        }

        setErrorMessage(_errorMessage);
    }, [name, email, birthdate]);

    useEffect(() => {
        setDisabled(
            !(name && email && birthdate && !errorMessage)
        );
    }, [name, email, birthdate, errorMessage]);

    const _handleSignupButtonPress = () => {};

    return (
        <ScrollView
         contentContainerStyle = {{flex : 1 }}
         extraScrollHeight = {20}>
            <Container>
              <ThemeProvider theme={theme}>
                <Image 
                style={{width: '50%', height: '28%', margin : 20, borderRadius : 100}}
                source={{uri:'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'
                }}
                />

                <View style = {{flex : 0.75, width : '100%', backgroundColor : '#ffffff',
                 shadowColor: "#000000",
                 shadowOpacity: 0.3,
                 shadowOffset: { width: 1, height: 1 } }}>
                  <Text style = {{fontWeight : "bold", margin : 10}}>공개여부</Text>

                  <Switch style = {{position : "absolute", top : 5, left : 80}}
                   trackColor={{false: '#767577', true: '#799462'}}
                   thumbColor={isEnabled ? '#ffffff' : '#ffffff'} 
                   ios_backgroundColor="#3e3e3e"
                   onValueChange={toggleSwitch}
                   value={isEnabled}
                  />
                  <Input 
                  // label = "Name"
                   value = {name}
                   onChangeText = {text => setName(text)}
                   onSubmitEditing = {() => {
                      setName(name.trim());
                      //emailRef.current.focus();
                   }}
                   onBlur = {() => setName(name.trim())}
                   placeholder = "Name"
                   returnKeyType = "next"/>
                   <Input
                    //ref = {emailRef}
                   // label = "Email"
                    value = {email}
                    onChangeText = {text => setEmail(removeWhitespace(text))}
                    //onSubmitEditing = {() => passwordRef.current.focus()}
                    placeholder = "Email"
                    returnKeyType = "next"
                    />
                  <Input
                   //ref = {birthdateRef}
                 //  label = "Birthdate"
                   value = {birthdate}
                   onChangeText = {text => setbirthdate(removeWhitespace(text))}
                   //onSubmitEditing = {() => passwordConfirmRef.current.focus()}
                   placeholder = "Birthdate"
                   returnKeyType = "done"
                   //isPassword
                   />
                </View>
                {/*<ErrorText>{errorMessage}</ErrorText>*/}

                <Text style = {{fontWeight : 'bold', margin : 10, left : -150}}>경험치 레벨</Text>

                <View style = {{flex : 0.2, width : '100%', backgroundColor : '#ffffff',
                 shadowColor: "#000000",
                 shadowOpacity: 0.3,
                 shadowOffset: { width: 1, height: 1 } , margin : 10}}>
                    <Text style = {{margin : 5, fontWeight : 'bold'}}>Level 2</Text>
                    <Progress.Bar style = {{left : 45}}
                  
                  progress={0.3} width={300} height = {25}
                  backgroundColor = '#fff3c2'
                  color={'#ffaf19'}
                  borderRadius = {20} />
                    </View>

                    <View style = {{flexDirection : 'row'}}>
                      <Buttons 
                      title = "프로필 편집"
                      style = {{flex : 1, backgroundColor : '#AB8E87'}}
                      onPress = {() => {}}/>

                      <Buttons 
                      title = "로그아웃"
                      style = {{flex : 1}}
                      onPress = {() => {}}/>

                    </View>  

              </ThemeProvider>
            </Container>
         </ScrollView>
        
    );

};

export default Mypage;