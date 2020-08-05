local widget= require ("widget")

local bg= display.newImage("img/grass.jpg")
bg.x=display.contentCenterX
bg.y=display.contentCenterY

w=display.contentWidth-20

ageMin=1
ageMax=100
age=ageMin
display.setStatusBar( display.HiddenStatusBar )

local group= display.newGroup() -- objects

Circle= display.newCircle( group ,display.contentCenterX,290 , 60 ): setFillColor(224/255, 224/255, 223/255)
RoundedRect=display.newRoundedRect(group, display.contentCenterX, 320, 320, 80,0 ):setFillColor(224/255, 224/255, 223/255)
display.newText( group, "Chose your age", display.contentCenterX,300 ,native.systemFont, 20 ):setFillColor(0)

local myAge=display.newText({
  parent=group,
  fontSize=20,
  text=age,
  x=display.contentCenterX,
  y=265,
  font=native.systemFont,
})
myAge:setFillColor(210/255, 93/255, 21/255)

group.y= -200



--------------------- Slaider


local optionSlider ={
  frames={
    {x=0, y=0, width=15, height=45},
    {x=16, y=0, width=130, height=45},
    {x=332, y=0, width=15, height=45},
    {x=153, y=0, width=15, height=45},
    {x=353, y=0, width=47, height=47},
  },

  sheetContentWidth= 400,
  sheetContentHeight= 45,
}

ageSlider= widget.newSlider
{
  sheet= graphics.newImageSheet("img/slider.png", optionSlider),
  leftFrame=1,
  middleFrame=2,
  rightFrame=3,
  fillFrame=4,
  handleFrame=5,
  frameWidth=15,
  frameHeight=45,
  handelWidth=45,
  handelHeight=45,
  top= 110,
  left= 38,
  right=10,
  width=250,
  height=47,
  orientation="horizontal",
  value=100*(age-ageMin)/(ageMax-ageMin),



  listener = function(event) -- отслеживание ползунка
age=math.round(ageMin+(ageMax-ageMin)*event.value/100)
myAge.text=age
  end
}



-- Buttons

local group2= display.newGroup() -- Slaider and Buttons

group2:insert(ageSlider)

ageMinusButton=widget.newButton {
parent=group2,
shape='roundedRect',
radius=5,
width=25,height=25,
left=2.5,top=110,
fontSize=40,
fillColor={default={46/255, 145/255, 176/255},over={222/255, 230/255, 102/255}},
labelColor={default={1}, over={0}},
label='-',

onPress=function(event)
  if(age>ageMin) then
    age=age-1
    myAge.text=age
    ageSlider:setValue(100*(age-ageMin)/(ageMax-ageMin))
  end
end
}



agePlusButton = widget.newButton {
parent=group2,
shape='roundedRect',
radius=5,
width=25,height=25,
left=290,top=110,
fontSize=40,
fillColor={default={46/255, 145/255, 176/255},over={222/255, 230/255, 102/255}},
labelColor={default={1}, over={0}},
label='+',

onPress=function(event)
  if(age<ageMax) then
    age=age+1
    myAge.text=age
    ageSlider:setValue(100*(age-ageMin)/(ageMax-ageMin))
  end
end
}



-----------------------  images


sex=""

local sexGroup= display.newGroup()

display.newRoundedRect(sexGroup, display.contentCenterX, display.contentCenterY, w, 130,10):setFillColor(225/255, 225/255, 234/255)

display.newText(sexGroup,"Choose your sex", display.contentCenterX,195, native.systemFont,22):setFillColor(0/255,0/255, 0/255)

sexSelect=display.newText(sexGroup,sex,display.contentCenterX,255,native.systemFont,20)
sexSelect:setFillColor(0/255,0/255, 0/255)



local maleOn = display.newImageRect( "img/male_active.png", 80, 80 )
maleOn.x = display.contentCenterX-100
maleOn.y = display.contentCenterY+15

local maleOff = display.newImageRect( "img/male.png", 80, 80 )
maleOff.x = display.contentCenterX-100
maleOff.y = display.contentCenterY+15

local femaleOn = display.newImageRect( "img/female_active.png", 80, 80 )
femaleOn.x = display.contentCenterX+100
femaleOn.y = display.contentCenterY+15

local femaleOff = display.newImageRect( "img/female.png", 80, 80 )
femaleOff.x = display.contentCenterX+100
femaleOff.y = display.contentCenterY+15

maleOn.isVisible=false
femaleOff.isVisible=true
maleOff.isVisible=true
femaleOn.isVisible=false



function selectMale(event)
  if(event.phase=="began") then
    sex="Men"
    sexSelect.text=sex
    maleOn.isVisible=true
    maleOff.isVisible=false
    femaleOn.isVisible=false
    femaleOff.isVisible=true
  end
  return true
end

function selectFemale(event)
  if(event.phase=="began") then
    sex="Women"
    sexSelect.text=sex
    maleOn.isVisible=false
    maleOff.isVisible=true
    femaleOn.isVisible=true
    femaleOff.isVisible=false
  end
  return true
end

maleOff:addEventListener("touch",selectMale)
femaleOff:addEventListener("touch",selectFemale)
