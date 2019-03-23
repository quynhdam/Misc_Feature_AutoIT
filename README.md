# HotShortCut

Create hotshortcut application written by AutoIT. 

This program will work as a tool to help your life better by adding shortcut to many daily tasks from simple to complex. 

#### Current features: 
- Open program
- Send keystrokes, keys, text, text in file into destination window (using both clipboard and simulated keyboard typing)
- Send mouse click (both direct and indirect click to destination window)
- Set window state, change transparency
- Set delay between actions

#### TODO features:
- Capture screenshoot
- Working with console

-----

## Actions
Action is the main object used inside this project. Action is defined as **big** action and *detailed* actions.

One action can have one or many detailed actions. 

Each action represent a task that need to be done.

Action location: `./Configs/action_configs.ini` This file follow standard __*.ini*__ format (as AutoIT `IniRead, IniWrite, IniDelete` only work in standardized __*.ini*__ file.

Action example:
```ini
[common]
count=2

[0]
name=action1
count=4
hotkey=Ctrl+Shift+L
1=3|HotShortCut.au3 - visualCode_Workspace (Workspace) - Visual Studio Code [Administrator]|Chrome Legacy Window|854|71|False|MOUSE_CLICK_PRIMARY|1|10|0||
2=4|Hala|Holo|3|255
3=4|Hala|Holo|0|255
4=2|False|True|True|False|Shift+Ctrl+R|

[1]
name=action2
count=2
hotkey=Ctrl+Shift+F
1=1|E:\SelfStudy\AutoIT\ISN_AutoIT_Studio\Projects\ScreenPreview\ScreenPreview_x64.exe|ScreenPreview_x64||True|False|False|False|False|9
2=1|start skype:|Skype||True|False|False|False|False|9

```
- `Common` section: Contains every fundamental properties of an action. Currently, only `count` which represent total number of actions is defined.
- `[0]`: Action indexed 0
- `count`:Number of detailed actions that were defined inside this action
- `hotkey`: Hotkey used to activate this action.
- 1,2,3...: The detailed actions which will be activated one by one follow A-Z order.


## File/folder hierarchy
### 1. GUI
This folder contains every graphic user interfaces (GUI) of the project. 

The main role of these files is taking care of every GUI related tasks (input, add, edit, delete, set GUI animations, etc)

There are two GUI: 
- Main action form (`GUI_Action.au`3): This GUI defines big actions, you can name the action, attach hotkey to it.
- Action details(`GUI_ActionDetails.au3`): The subtasks of action defined in the Main action form.
- GUI Designer files (`*.kxf`): Used by Koda FormDesigner

### 2.Control
Contain controls using in the application. 

At the moment, only GUI control is developed. 

##### `Global_Variable.au3`: Contains global constant, variables, enums used in the project. For the details, please read the region comments

##### `Utility_Script.au3`: Contains utility scripts about read/write configuration files, debug codes. 

##### `Test.au3`: File used to test anything you want.

### 3. Configs
Contain configuration files used inside the application. 

### 4. Images
Contain all the images/icons used inside the application.

### 5. Testing
Anything you want to add/test.

### 6. Libraries
Any librariy (UDF) should be added into this folder

