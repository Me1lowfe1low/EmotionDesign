# This project implements EmotionDesign app

<p  align="center">
<img src="EmotionDesign/Images/EmotionDesignLogo.png" width="200" height="200">
</p>

> EmotionDesign is an app that allows users to track their emotions daily \
> and analyse the range of their feelings over time using statistics. \
> Currently working on redesingning app. So the images below are not the save as application would look like

<a id="TableOfContents"></a>
# Table of contents
+ [Description](#Description)
    + [Technology](#Technology)
    + [Main view](#MainView)
        + [Add entry tab](#AddEntry)
        + [Info tab](#Info)
        + [Analysis tab](#Analysis)
    + [Initial emotion selection tab](#InitialEmotion)
	+ [Common emotion selection](#CommonEmotion)
	+ [Add emotion to history](#SaveEmotion)

# <a name="Description">Description</a>

This application was created with intention to help users to control and analyze their emotions. \
It contains a wide range of emotions that user could choose and review an infographics in day slices \
Finally one could review how all emotions they felt are accumulated in the colorful graph. \
The less negative emotions were felt - the clearer would be the image.

[Back to the table of contents ⬆](#TableOfContents)

## <a name="Technology">Technology</a>
A brief description about the project: 
- [x] The project uses [MVVM](https://en.wikipedia.org/wiki/Model–view–viewmodel) model  
- [x] The initial data is holded in json file, thus, it is easy to add new data to the app 
- [x] Persistence of data is achieved by using [Core Data](https://developer.apple.com/documentation/coredata) 


[Back to the table of contents ⬆](#TableOfContents)

<a id="MainView"></a>
## Main view
At the main view there is a TabView with 3 tabs that one could find below. \
All tabs are interactive and would be described further in this guide.

<img src="EmotionDesign/Images/0_mainWindow_darkTheme.jpg" width="200" ><img src="EmotionDesign/Images/5_infoView_darkTheme.jpg" width="200" >|<img src="EmotionDesign/Images/6_emotionAnalysisEmpty_darkTheme.jpg" width="200" >

[Back to the table of contents ⬆](#TableOfContents)

<a id="AddEntry"></a>
### Add entry tab
This is the first tab that user could find in the app. By pressing the button the user would be navigated further to \
the [Initial emotion selection tab](#InitialEmotion), there they could choos one of the several initial emotions.

| Dark Theme | Light Theme |
| --- | --- |
|<img src="EmotionDesign/Images/0_mainWindow_darkTheme.jpg" width="300" >|<img src="EmotionDesign/Images/0_mainWindow_lightTheme.jpg" width="300" >|

[Back to the table of contents ⬆](#TableOfContents)

<a id="Info"></a>
### Info tab
This tab provides a brief description of initial emotions that you may face. 

| Dark Theme | Light Theme |
| --- | --- |
|<img src="EmotionDesign/Images/5_infoView_darkTheme.jpg" width="300" >|<img src="EmotionDesign/Images/5_infoView_lightTheme.jpg" width="300" >|

[Back to the table of contents ⬆](#TableOfContents)

<a id="Analysis"></a>
### Analysis tab
At the Analysys tab there are two sections: the first section provides information about emotions users felt day by day \
The second section describes in graphical manner all emotions that were added to the history by the user. \
Users could review all this data, delete exact days from their emotion history or clear all the data. 

Dark Theme
| Clean View | Filled view | Clear view |
| --- | --- | --- |
|<img src="EmotionDesign/Images/6_emotionAnalysisEmpty_darkTheme.jpg" width="300" >|<img src="EmotionDesign/Images/6_emotionAnalysisFilled_darkTheme.jpg" width="300" >|<img src="EmotionDesign/Images/6_emotionAnalysisCleanButtonPressed_darkTheme.jpg" width="300" >|
												      
Light Theme
| Clean View | Filled view | Clear view |
| --- | --- | --- |
|<img src="EmotionDesign/Images/6_emotionAnalysisEmpty_lightTheme.jpg" width="300" >|<img src="EmotionDesign/Images/6_emotionAnalysisFilled_lightTheme.jpg" width="300" >|<img src="EmotionDesign/Images/6_emotionAnalysisCleanButtonPressed_lightTheme.jpg" width="300" >|								

[Back to the table of contents ⬆](#TableOfContents)

<a id="InitialEmotion"></a>
## Initial emotion selection tab
Initial Emotion tab is an auxiliarytab, that is performed in a gradient line with initial emotions on it. \
Line is clickable, so users could chose the general emotion they felt. After choosen one of the emotions, \
the relevant common emotions are being listed below 

| Dark Theme | Light Theme |
| --- | --- |
|<img src="EmotionDesign/Images/1_choseGeneralEmotion_darkTheme.jpg" width="300" >|<img src="EmotionDesign/Images/1_choseGeneralEmotion_lightTheme.jpg" width="300" >|

[Back to the table of contents ⬆](#TableOfContents)

<a id="CommonEmotion"></a>
###  Common emotion selection
This view is fully interactive. And user could chose one of the emotions they've felt. \
TO confirm the choice the button belove should be pressed, thus, the user will be redirected to the additional view.

| Dark Theme | Light Theme |
| --- | --- |
|<img src="EmotionDesign/Images/2_choseCommonEmotion_darkTheme.jpg" width="300" >|<img src="EmotionDesign/Images/2_choseCommonEmotion_lightTheme.jpg" width="300" >|

[Back to the table of contents ⬆](#TableOfContents)

<a id="SaveEmotion"></a>
###  Add emotion to history
At this view users could comment their emotion choice or leave it empty as it is. \
To add chosen emotions to the history users should press the 'confirm' button.

| Dark Theme | Light Theme |
| --- | --- |
|<img src="EmotionDesign/Images/4_confirmEmotionChoice_darkTheme.jpg" width="300" >|<img src="EmotionDesign/Images/4_confirmEmotionChoice_lightTheme.jpg" width="300" >|

[Back to the table of contents ⬆](#TableOfContents)
