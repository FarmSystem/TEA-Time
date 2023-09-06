import React from 'react';
import {TabNavigation} from './src/navigations/Tab';
import {NavigationContainer} from '@react-navigation/native';

const App = () => {
    return (
        <NavigationContainer>  
          <TabNavigation />
        </NavigationContainer>

    );
  };

/*const App = () => {
    return (
        <View style = {viewStyles.container}>

            <Header />
            <List />
            <Contents />
            <Footer />
        </View>

    );
};*/

export default App;