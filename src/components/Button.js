import React from 'react';
import styled from 'styled-components/native';
import { View, Text } from 'react-native';
import { MaterialCommunityIcons } from '@expo/vector-icons';

const ButtonContainer = styled.TouchableOpacity`
background-color : #FFF9F2;
border-radius : 15px;
padding : 15px 40px;
margin : 10px 0px;
justify-content : space-between;
`;

const Title = styled.Text`
font-size : 15px;
font-weight : bold;
color : black;
`;



const Button = props => {
    return (
        <ButtonContainer>
            <View style={{ flexDirection: 'row', alignItems: 'center' }}>
                <Title>{props.title}</Title>
                <MaterialCommunityIcons name="filter-variant" size={24} color="black" />
            </View>
        </ButtonContainer>
    );
};

export default Button;