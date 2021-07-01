# Contributing to HFPE
:grinning: Thank you for taking your time to contribute to HFPE :grinning:

## Short question and answers
**How do I use GitHub?**:
I would recommend reading a guide or watching a tutorial to both Git and GitHub.
[Link to guide](https://guides.github.com/introduction/git-handbook/).

**How do the version numbers work**:
Example: v1.2.3 = Version MANJOR.MINOR.PATCH
Patch is for small bug fixes. Minor is for collections of patches and features. 
Major is for large collections of minor updates or a large codebase change.

**The difference between contributing and modding**:
Contributing is adding the main HFPE source code. Contributed code will likely be deployed in future versions of the project.
Modding is adding to your own version of the HFPE source code. You can do what you like with this source code
as long as it is withing the license agreement.

## How do I contribute?
Firstly, create an issue regarding what you want changed: bug fix or feature request.
There are templates in the issues section to guide you into creating a correct issue.
Once your issue has been published, you must wait until it is verified by the repository developer.

### Why must I create an issue?
Simply put, I do not want you to start working on a bug fix or feature request without me verifying 
it is either not already being worked on or is not something I think will be benefitual to the project.
I do not want people spending hours on contributing code when it unlikely to be added to the project.

## My bug fix or feature request has been verified!
That's great! Your issue should now be added to the projects tab. It will likely be under the next version number.
Now that your issue has been verified you can begin working on the issue. If you have not already, fork the project 
and start coding!

### I have finished my changes.
Create a pull request from your forked repository to the main repository.
You should describe what you changed and reference your original issue.
If all well is good, your pull request will be merged into the master branch and your issue will be closed.

### My issue has been closed?!
After an amount of time has past your issue may be closed. 
DO not worry! You can still submit a pull request and have your changed added.

# Code guidelines
There are some guidelines on how code should be written.
**Why?** If all code in the project is consistant: code will be easier to read and everyone will be able to understand each other.
These are guidelines; your code is not going to be rejected for a few mishaps though, ignoring the guidelines may give you that
result!

## Naming convention
Variable and function names must be consistant with what they store/achieve.
Variable and function names use [snake_case](https://en.wikipedia.org/wiki/Snake_case).
Scenes (.tscn), godot scripts (.gd) and classes are [PascelCase](https://techterms.com/definition/pascalcase).
[Singletons](https://docs.godotengine.org/en/stable/getting_started/step_by_step/singletons_autoload.html) are [camelCase](https://en.wikipedia.org/wiki/Camel_case).

## Static typing
Godot's [static typing](https://docs.godotengine.org/en/stable/getting_started/scripting/gdscript/static_typing.html) is to be used when possible.
Examples:
```
# Delaring using static types
var age := 10
var _texture := Texture.new()
var filename: String

# functions with static types
func set_filenane(text: String) -> void:
    filename = text

func is_dead() -> bool:
    if age > 100:
        return true
    return false
```
