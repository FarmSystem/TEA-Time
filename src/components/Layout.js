import React from 'react';
import {StyleSheet, SafeAreaView, Text} from 'react-native';

export const Header = () => {
    return (
        <SafeAreaView style = {[styles.container, styles.header]}>
            <Text style = {styles.text}> DIARY LIST</Text>
        </SafeAreaView>
    );
};

export const Contents = () => {
    return (
        <SafeAreaView style = {[styles.container, styles.contents]}>
            <Text style = {styles.text}>Contents</Text>
        </SafeAreaView>
    );
};


export const Footer = () => {
    return (
        <SafeAreaView style = {[styles.container, styles.footer]}>
            <Text style = {styles.text}>Footer</Text>
        </SafeAreaView>
    );
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