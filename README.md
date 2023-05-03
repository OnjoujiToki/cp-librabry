**Introduction**

Competitive programming is a highly popular and ever-growing activity that attracts students, professionals, and hobbyists who wish to improve their coding skills and participate in contests hosted on various websites. The Competitive Programming Library iOS application is designed to provide a comprehensive library of competitive programming concepts, tricks, and algorithms in a mobile-friendly format. The app's main objective is to facilitate on-the-go learning and help users efficiently utilize their spare time to memorize essential concepts and techniques in competitive programming.

 

**Features**

The Competitive Programming Library iOS application offers several essential features, such as:

1. A comprehensive library of competitive programming concepts, tricks, and algorithms, organized by topic, covering areas such as graph theory, dynamic programming, combinatorics, number theory, and geometry.
2. A feature to set reminders for upcoming competitive programming contests, which will send notifications to the user's device or add the event to their calendar.
3. The ability to search for specific tags within the library, making it easy to find relevant content.
4. A feature to allow users to mark items as "favorites" for quick access later, facilitating personalized learning experiences.
5. A feature enabling users to write, compile, and execute code directly within IDE.

 

**Work Flow**

![Graphical user interface, text, application, chat or text message  Description automatically generated](file:////Users/siyuanhe/Library/Group%20Containers/UBF8T346G9.Office/TemporaryItems/msohtmlclip/clip_image001.jpg)![Graphical user interface, text, application, chat or text message  Description automatically generated](file:////Users/siyuanhe/Library/Group%20Containers/UBF8T346G9.Office/TemporaryItems/msohtmlclip/clip_image002.jpg)

1. Onboarding: Login to the existing account or create a new account

 

![Graphical user interface, application  Description automatically generated](file:////Users/siyuanhe/Library/Group%20Containers/UBF8T346G9.Office/TemporaryItems/msohtmlclip/clip_image003.jpg)![Graphical user interface, text, application, email  Description automatically generated](file:////Users/siyuanhe/Library/Group%20Containers/UBF8T346G9.Office/TemporaryItems/msohtmlclip/clip_image004.jpg)![Text  Description automatically generated](file:////Users/siyuanhe/Library/Group%20Containers/UBF8T346G9.Office/TemporaryItems/msohtmlclip/clip_image005.jpg)

2. Problem: Display a list of problems, along with their difficulty level and tags, which allows users to filter the list based on difficulty and tags. Users can also bookmark or remove bookmarks from problems, and clicking on a problem will allow them to view the details of that problem.

 

![Graphical user interface, text, application, chat or text message  Description automatically generated](file:////Users/siyuanhe/Library/Group%20Containers/UBF8T346G9.Office/TemporaryItems/msohtmlclip/clip_image006.jpg)![A picture containing table  Description automatically generated](file:////Users/siyuanhe/Library/Group%20Containers/UBF8T346G9.Office/TemporaryItems/msohtmlclip/clip_image007.jpg)

3. Contests: Display a list of contests. Users should be able to click on a contest to view more details about it and have the option to add it to their calendar.

 

![Graphical user interface, application, Teams  Description automatically generated](file:////Users/siyuanhe/Library/Group%20Containers/UBF8T346G9.Office/TemporaryItems/msohtmlclip/clip_image008.jpg)

4. To-Do List: Display a list of problems bookmarked by users, with the option to delete them.

 

 

 

 

![Graphical user interface, application  Description automatically generated](file:////Users/siyuanhe/Library/Group%20Containers/UBF8T346G9.Office/TemporaryItems/msohtmlclip/clip_image009.jpg)

5. For You: Recommend some problems for users.

 

![Graphical user interface, text, application, chat or text message  Description automatically generated](file:////Users/siyuanhe/Library/Group%20Containers/UBF8T346G9.Office/TemporaryItems/msohtmlclip/clip_image010.jpg)

6. Profile Page: Update the handle, display the avatar, contributions, current rating, and highest rating. To Click the button in the upper right corner to log out of the current account.



 

 

 

 

 

![Graphical user interface, text, application  Description automatically generated](file:////Users/siyuanhe/Library/Group%20Containers/UBF8T346G9.Office/TemporaryItems/msohtmlclip/clip_image011.jpg)![img](file:////Users/siyuanhe/Library/Group%20Containers/UBF8T346G9.Office/TemporaryItems/msohtmlclip/clip_image012.jpg)![Graphical user interface, application  Description automatically generated](file:////Users/siyuanhe/Library/Group%20Containers/UBF8T346G9.Office/TemporaryItems/msohtmlclip/clip_image013.jpg)![Graphical user interface, text, application  Description automatically generated](file:////Users/siyuanhe/Library/Group%20Containers/UBF8T346G9.Office/TemporaryItems/msohtmlclip/clip_image014.jpg)

7. About: Display the app authors' information, including links to their GitHub profiles, and enable users to email them using the default email client on their phones.

 

![Graphical user interface, text, application  Description automatically generated](file:////Users/siyuanhe/Library/Group%20Containers/UBF8T346G9.Office/TemporaryItems/msohtmlclip/clip_image015.jpg)

8. IDE: Integrate an online IDE within the application for a seamless coding experience.

 

**Techniques**

1. Use SwiftUI as the ui toolkit.
2. Firebase Authentication to authenticate users to your app.
3. Add a contest event to the user's calendar using the EventKit framework.
4. Import Fonts from external libraries.
5. When tapping on a list item, use a 'NavigationLink' to display problem details and load the content from a URL as the user navigates to the detail view.
6. Use 'onTapGesture' to open a URL in the default browser when a user taps a view.
7. Create hyperlinks with 'mailto' open the default email client on the user's device with a new email draft.
8. Utilize the Codeforces API to retrieve data about handles, problems, and contests.
9. Create a launch screen using a storyboard.
10. Incorporate 'animation' to display engaging slide transitions on the About page.