import React from 'react';
import styled from 'styled-components/native';
//import {Dimensions} from 'react-native';

const StyledInput = styled.TouchableOpacity`
width : 350px;
height : 100px;
margin : 3px 0;
padding : 15px 20px;
border-radius : 10px;
justify-content: space-around;
background-color : ${({theme}) => theme.itemBackground};
color : ${({theme}) => theme.text};
`;

//width : ${({width}) => width - 40}px;


/*const Show = () => {
    const width = Dimensions.get('window').width;
    return <StyledInput width = {width} />;
};*/

const Text = styled.Text`
font-size : 25px;
font-weight : 600;
color : white;
text-align : center;
align-items : center;
`

const Show = props => {
    //const width = Dimensions.get('window').width;
    return (
        <StyledInput>
            <Text>{props.text}</Text>
        </StyledInput>
    );
};

export default Show;