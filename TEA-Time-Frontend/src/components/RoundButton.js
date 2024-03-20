import React from 'react';
import styled from 'styled-components/native';

const ButtonContainer = styled.TouchableOpacity`
background-color : black;
border-radius : 35px;
width :60px;
height : 60px;
justify-content : space-between;
shadow-color : rgb(50,50,50);
shadow-opacity : 0.5;
`;

const Title = styled.Text`
font-size : 35px;
font-weight : 600;
color : white;
text-align : center;
align-items : center;
`;

const RoundButton = props => {
    return (
        <ButtonContainer>
            <Title>{props.title}</Title>
        </ButtonContainer>
    );
};

export default RoundButton;



/*import React, { Component } from 'react';
import { StyleSheet, View } from 'react-native';
import ActionButton from 'react-native-action-button';
import Icon from 'react-native-vector-icons/Ionicons';


export default class RoundButton extends Component {

  render() {
    return (
      <View style={{backgroundColor : '#FFF9F2'}}>
        <ActionButton buttonColor="black">

        </ActionButton>
      </View>
    );
  }

}

const styles = StyleSheet.create({
  container : {
        flex : 1,
        flexDirection : 'column',
        alignItems : 'flex-end',
  },  
  actionButtonIcon: {
    fontSize: 20,
    height: 22,
    color: 'white',
    backgroundColor : '#FFF9F2',
    ...Platform.select({
      ios : {
        shadowColor : 'black',
        shadowOpacity : 0.2,
        shadowRadius : 3,
      },
      android : {
        elevation : 10,
      },
    }),
  },
});*/



/*import React, { Component } from 'react';
import { StyleSheet, TouchableOpacity, Text } from 'react-native';

export default class RoundButton extends Component {
    render() {
        return (
            <TouchableOpacity style={styles.button}>
                <Text style={styles.text}>+</Text>
            </TouchableOpacity>
        );
    }
}

export const styles = StyleSheet.create({
    container : {
        flex : 1,
        flexDirection : 'column',
        alignItems : 'flex-end',
    },
    button : {
            backgroundColor : 'green',
            alignItems : 'center',
            width : 70,
            height : 70,
            marginButtom : 30,
            borderRadius : 35
        },


    text : {
        fontSize : 30,
        textAlign : 'center',
        color : 'white'
    }
});*/