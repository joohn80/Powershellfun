# Learn-Powershell-Array-Examples
# Create simple array of strings
$myArray = "abc", "xyz", "pqr", "dcb"

# Before
$myArray

# Update whole array
$myArray = "new", "values"


# After
Write-Host "############ After #########"
$myArray

# $myArray = @("abc", "xyz", "pqr", "dcb")
# Using @ or () makes a empty array
# $myArray.Length shows the lenght of the array

#You can create an array with a value, two dots and a higher value
#Powershell is smart enough to make the whole array with that

$myArray1 = 1..9
$myArray1

#this also works bakwards

$myArray2 = 9..1
$myArray2

#If we add´another line we can check if a value is inside of the Array

$myArray3 = 14..8
$myArray3
$myArray3.Contains(11)

#This part shows that it's true since it does contain 11

#If we instead add a value that doesn't exist in the array like this

$myArray3 = 14..8
$myArray3
$myArray3.Contains(18)

#It will give you the answer "False"

#we can add -notcontains

$myArray3 = 14..8
$myArray3
$myArray3 -notcontains(18)

#You can sort the Array it using a pipeline Like this
$myArray3 | Sort-Object

