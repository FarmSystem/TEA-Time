import React from 'react';
import styled from 'styled-components/native';
import PropTypes from 'prop-types';


const Container = styled.View`
flex-direction : row;
align-items : center;
background-color : ${({theme}) => theme.itemBackground};
border-radius : 10px;
padding : 5px;
mRGIN : 3PX 0PX;
`;

const Contents = styled.Text`
flex : 1;
font-size : 24px;
color : ${({theme}) => theme.text};
`;

const Task = ({task}) => {
    return (
        <Container>
            <Contents>{text}</Contents>
        </Container>
    );
};

Task.propTypes = {
    text : PropTypes.string.isRequired,
};

export default Task;