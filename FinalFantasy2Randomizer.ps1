
#Final Fantasy II Randomizer
#Programmed by PheonixMMKC777
$VersionNumber = "v1.3.3"


Add-Type -assembly System.Windows.Forms


#region Init Variables

$PlayWav=New-Object System.Media.SoundPlayer
$PlayWav.SoundLocation="$CurrentDir\assets\Complete.wav"

$CurrentDir = Get-Location
$RandomByteList = 0..255

$FirionHandList = 00,128
$MariaHandList = 01,129
$GuyHandList = 02,130
$MinwuHandList = 03,131
$JosefHandList = 04,132
$GordonHandList = 05,133
$LaylaHandList = 06,134
$RichardHandList = 07,135
$LeonHandList = 08,136

$KeyItemByteList = 0..15
$ItemByteList = 16..48
$TreasureByteList = 01..191
$WeaponByteList = 49..111

               #Shields  #Knifes   #Canes    #Spears       #Swords        #Axes     #Bows
$WeaponTier1 = 49,50,51, 58,59,60, 65,66,67, 74,75,76,    83,84,85,86,    97,98,99, 104,105,106
$WeaponTier2 = 52,53,54, 61,62,    68,69,70, 77,78,79,    87,88,89,90,91, 100,101,  107,108,109
$WeaponTier3 = 55,56,57, 63,64,    71,72,73, 80,81,82,    92,93,94,95,96, 102,103,  110,111
 
$WeaponTier4 = 57,64,73,82,96,103,111




$ArmorByteList = 112..152
                #Helm       #Heavy      #Light       #Arms
$ArmorTier1 = 112,113,114, 122,123,124, 133,134,     143,144
$ArmorTier2 = 115,116,117, 125,126,     135,136,     145,146,147
$ArmorTier3 = 118,119,     127,128,129, 137,138,139, 148,149,150
$ArmorTier4 = 120,121,     130,131,132, 140,141,142, 151,152



$SpellByteList = 153..191 #These are the TOMES OR BOOKS!!!




$MagicByteList = 192..231 # These are the SPELLS THEMSELVES

$RandomBaseHp = 32..80
$RandomBaseStat = 5..15
$RandomPlayerSprite = 0..8

$RandomWeaponAddress = 0x0,0x2,0x4,0x6,0x8,0xA,0xC,0xE

$RandomPaletteValues1 = 1..12
$RandomPaletteValues2 = 17..28
$RandomPaletteValues3 = 33..44
$RandomPaletteValues4 = 49..60
$RandomPaletteArrayDark = ($RandomPaletteValues1,$RandomPaletteValues2)
$RandomPaletteArrayLight = ($RandomPaletteValues3,$RandomPaletteValues4)

$RandomHexValue = 0x00..0xFE
$RandomPaletteMixup = 0x55,0xaa,0xc3,0xf0,0x0f, 0x66, 0x99, 0xdc, 0x23

#Rest is bs pretty sure

# Armor Bytes     70 - 98


<#

    Flag names as follows

    DoubleWalkSpeed     = DW
    StartWith2Spell     = 2S
    Randomizeenemyloot  = RL
    RandomizePlayerPal  = RP
    RandomizedShops     = RS
    TieredShops         = TS
    RandomizeSprites    = RC
    RandomizeOffhand    = RH
    RandomizeBaseStat   = BS
    LockWeaponTypes     = LW
    SoloChallenges      = SC










#>



#endregion Init Variables

function FindRom 
{

    #this thing has an eternal hatred for spaces
    $CheckRom = Test-Path -Path "$CurrentDir\Final_Fantasy_2_(Tr).nes"

    
    if ($CheckRom -eq $false) {
    NoRom  
   
    } Else {
    
    Main
    }
    

}

Function NoRom {

    #icon but base64-ified
    $iconBase64      = 'iVBORw0KGgoAAAANSUhEUgAAAEAAAABABAMAAABYR2ztAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAElBMVEUAAAAAAACBUTbw0LA/SMz////WgOHMAAAAAXRSTlMAQObYZgAAAAFiS0dEBfhv6ccAAAAHdElNRQflChwDAgzj5EDnAAAAAW9yTlQBz6J3mgAAAIxJREFUSMfF1d0NgDAIBOCuwAquwArdfya9XBBqqk8C96CNfDHnXxzjjoSMXdKByBGyIelgHXcAjD9JAXiWVK0HPsZItQPYrUJUsa0HPkJBQ4GkA5F5hYTBmseqAEsa4ppsuYpUwHJzGsG+B3DgbLmGdOAvDMva46oF/tqgoNXsBC+/tQIQP6DPc/wPTgRisoEQucWoAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIxLTEwLTI4VDAzOjAyOjExKzAwOjAwCh6BJQAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMS0xMC0yOFQwMzowMjoxMSswMDowMHtDOZkAAAAASUVORK5CYII='
    $iconBytes       = [Convert]::FromBase64String($iconBase64)
    $stream          = New-Object IO.MemoryStream($iconBytes, 0, $iconBytes.Length)
    $stream.Write($iconBytes, 0, $iconBytes.Length)

$NoRom_Window = New-Object System.Windows.Forms.Form
$NoRom_Window.Text = "Rom Not Found"
$NoRom_Window.Size = "280,200"
$NoRom_Window.BackColor = "Blue"
$NoRom_Window.Icon = [System.Drawing.Icon]::FromHandle((New-Object System.Drawing.Bitmap -Argument $stream).GetHIcon())

$NoRom_Label = New-Object System.Windows.Forms.Label
$NoRom_Label.Text = "Rom does not exist, place`n`"Final_Fantasy_2_(Tr).nes`" `nIn this directory and try again."
$NoRom_Label.Size = "260,80"
$NoRom_Label.Location = "20,20"
$NoRom_Label.ForeColor = "white"
$NoRom_Label.Font = "Arial, 12"

    $Deathimg = (get-item "$CurrentDir/assets/death.png")
    $Deathimg = [System.Drawing.Image]::Fromfile($Deathimg)
    $Death = new-object Windows.Forms.PictureBox
    $Death.Image = $Deathimg
    $Death.Size = "80,60"
    $Death.Location = "90,95"

$NoRom_Window.Controls.Add($NoRom_Label)
$NoRom_Window.Controls.Add($death)
$NoRom_Window.ShowDialog()

}





function Main {

    #icon but base64-ified
    $iconBase64      = 'iVBORw0KGgoAAAANSUhEUgAAAEAAAABABAMAAABYR2ztAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAElBMVEUAAAAAAACBUTbw0LA/SMz////WgOHMAAAAAXRSTlMAQObYZgAAAAFiS0dEBfhv6ccAAAAHdElNRQflChwDAgzj5EDnAAAAAW9yTlQBz6J3mgAAAIxJREFUSMfF1d0NgDAIBOCuwAquwArdfya9XBBqqk8C96CNfDHnXxzjjoSMXdKByBGyIelgHXcAjD9JAXiWVK0HPsZItQPYrUJUsa0HPkJBQ4GkA5F5hYTBmseqAEsa4ppsuYpUwHJzGsG+B3DgbLmGdOAvDMva46oF/tqgoNXsBC+/tQIQP6DPc/wPTgRisoEQucWoAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIxLTEwLTI4VDAzOjAyOjExKzAwOjAwCh6BJQAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMS0xMC0yOFQwMzowMjoxMSswMDowMHtDOZkAAAAASUVORK5CYII='
    $iconBytes       = [Convert]::FromBase64String($iconBase64)
    $stream          = New-Object IO.MemoryStream($iconBytes, 0, $iconBytes.Length)
    $stream.Write($iconBytes, 0, $iconBytes.Length)

    #Main Gui elements
    
    $main_Window = New-object System.Windows.Forms.Form
    $main_Window.Size = "440,330"
    $main_Window.Text = "Final Fantasy II (NES) Randomizer $versionnumber"
    $Main_Window.Icon = [System.Drawing.Icon]::FromHandle((New-Object System.Drawing.Bitmap -Argument $stream).GetHIcon())


    $BraggingRights = New-Object System.Windows.Forms.Label
    $BraggingRights.Text = "Programmed by: PheonixMMKC777"
    $BraggingRights.size = "110,46"
    $BraggingRights.Location = "30,195"
    $BraggingRights.Font = "Arial, 9"


    $PartySelectMenu = New-Object System.Windows.Forms.Form
    $PartySelectMenu.Size = "230,170"
    $PartySelectMenu.Text = "Party"

    $FlagList = New-Object System.Windows.Forms.Label
    $FlagList.text = "Flags *:  `nAlso if it has this * symbol, it is incomplete :( "
    $FlagList.Location = "170,248"
    $FLaglist.Size = "300, 60"

    $RandomizeButton = New-Object System.windows.forms.button
    $RandomizeButton.Text = "Import"
    $RandomizeButton.Location = "30,240"
    $RandomizeButton.Size = "60,35"
    $RandomizeButton.ADD_CLICK({EvaluateRandomizer})

    $RandoComplete = New-Object System.Windows.Forms.Label
    $RandoComplete.text = "Done!"
    $RandoComplete.Location = "100,250"
    $RandoComplete.Size = "40, 60"


    #region Tabs

    $TabControl = new-Object System.Windows.Forms.TabControl
    $TabControl.Size = "250,200"
    $TabControl.Location = "170,40"
    

    $TabPlayerPage = New-Object System.Windows.Forms.TabPage
    $TabPlayerPage.Text = "Player"
    

    $TabShopPage = New-Object System.Windows.Forms.TabPage
    $TabShopPage.Text = "Shop"

    $TabGamePage = New-Object System.Windows.Forms.TabPage
    $TabGamePage.Text = "Game"

    $TabChaosPage = New-Object System.Windows.Forms.TabPage
    $TabChaosPage.Text = "Chaos"

    $TabOtherPage = New-Object System.Windows.Forms.TabPage
    $TabOtherPage.Text = "Other"

    $RandomizePlayerSprite = New-Object System.Windows.Forms.CheckBox
    $RandomizePlayerSprite.Text = "Randomize Player Sprites"
    $RandomizePlayerSprite.Size = "200,30"
    $RandomizePlayerSprite.Location = "20,20"

    $RandomizePlayerHand = New-Object System.Windows.Forms.CheckBox
    $RandomizePlayerHand.Text = "Randomize OffHands"
    $RandomizePlayerHand.Size = "200,30"
    $RandomizePlayerHand.Location = "20,50"

    $RandomizePlayerStats = New-Object System.Windows.Forms.CheckBox
    $RandomizePlayerStats.Text = "Randomize Base Stats"
    $RandomizePlayerStats.Size = "200,30"
    $RandomizePlayerStats.Location = "20,80"

    $CustomPlayerPal = New-Object System.Windows.Forms.CheckBox
    $CustomPlayerPal.Text = "Randomize Player Palette"
    $CustomPlayerPal.Size = "200,30"
    $CustomPlayerPal.Location = "20,110"

    $RandomizeTreasureChest = New-Object System.Windows.Forms.CheckBox
    $RandomizeTreasureChest.Text = "Randomize Treasures"
    $RandomizeTreasureChest.Size = "200,30"
    $RandomizeTreasureChest.Location = "20,140"


    $DoubleWalkSpeed = New-Object System.Windows.Forms.CheckBox
    $DoubleWalkSpeed.Text = "Double Walk Speed"
    $DoubleWalkSpeed.Location = "20,20"
    $DoubleWalkSpeed.Size = "200,30"

    $RandomizeLootTable = New-Object System.Windows.Forms.CheckBox
    $RandomizeLootTable.Text = "Randomize + Fill Enemy Loot"
    $RandomizeLootTable.Size = "200,30"
    $RandomizeLootTable.Location = "20,80"


    $WeaponLock = New-Object System.Windows.Forms.CheckBox
    $WeaponLock.Text = "Lock Weapon Types"
    $WeaponLock.Size = "200,30"
    $WeaponLock.Location = "20,50"

    $RandomizeShops = New-Object System.Windows.Forms.CheckBox
    $RandomizeShops.Text = "Randomize Shops"
    $RandomizeShops.Size = "200,30"
    $RandomizeShops.Location = "20,20"

    $TieredShops = New-Object System.Windows.Forms.CheckBox
    $TieredShops.Text = "Tiered Shops"
    $TieredShops.Size = "200,30"
    $TieredShops.Location = "20,50"

    $StartWithSpells = New-Object System.Windows.Forms.CheckBox
    $StartWithSpells.Text = "Start With 2 Spells"
    $StartWithSpells.Location = "20,50"
    $StartWithSpells.Size = "200,30"



    $SoloChallenge = New-Object System.Windows.Forms.CheckBox
    $SoloChallenge.Text = "Solo Challenge"
    $SoloChallenge.Size = "200,30"
    $SoloChallenge.Location = "20,20"

    $MaxFirionStat = New-Object System.Windows.Forms.CheckBox
    $MaxFirionStat.Text = "Max Firion's Stats (Debug)"
    $MaxFirionStat.Size = "200,30"
    $MaxFirionStat.Location = "20,20"

    $NoBloodSwords = New-Object System.Windows.Forms.CheckBox
    $NoBloodSwords.Text = "Replace Blood sword with Onion"
    $NoBloodSwords.Size = "200,30"
    $NoBloodSwords.Location = "20,50"

    $NoStatDecrease = New-Object System.Windows.Forms.CheckBox
    $NoStatDecrease.Text = "Stats Never Go Down"
    $NoStatDecrease.Size = "200,30"
    $NoStatDecrease.Location = "20,80"

    $SpeedupMagicLV = New-Object System.Windows.Forms.CheckBox
    $SpeedupMagicLV.Text = "Speed up magic levels"
    $SpeedupMagicLV.Size = "200,30"
    $SpeedupMagicLV.Location = "20,110"


    # Player Select Menu

    $PlayerSelectButton = New-Object System.Windows.Forms.Button
    $PlayerSelectButton.Text = "Party `nSelect"
    $PlayerSelectButton.Size = "60,40"
    $PlayerSelectButton.Location = "20,120"
    $PlayerSelectButton.ADD_CLICK({PickParty})

    $Player_Label = New-Object System.Windows.Forms.Label
    $Player_Label.Location = "10,15"
    $Player_Label.Size = "50,65"
    $Player_Label.Text = "Player1 `n`nPlayer2  `n`nPlayer3"

    $Player_Tips = New-Object System.Windows.Forms.Label
    $Player_Tips.Location = "130,5"
    $Player_Tips.Size = "100,110"
    $Player_Tips.Text = "Firion = 00 `nMaria = 01 `nGuy = 02 `nMinwu = 03 `nJosef = 04 `nGordon = 05 `nLayla = 86 `nRichard = 07 `nLeon = 88" 


    $Player1_Textbox = New-Object System.Windows.Forms.TextBox
    $Player1_Textbox.Location = "70,10"
    $Player1_Textbox.Size = "40,15"

    $Player2_Textbox = New-Object System.Windows.Forms.TextBox
    $Player2_Textbox.Location = "70,35"
    $Player2_Textbox.Size = "40,15"

    $Player3_Textbox = New-Object System.Windows.Forms.TextBox
    $Player3_Textbox.Location = "70,60"
    $Player3_Textbox.Size = "40,15" 


    $Character_Select_Menu = New-object System.Windows.Forms.Form
    $Character_Select_Menu.Size = "250,160"
    $Character_Select_Menu.Text = "Character Select"

    $Character_Import_Button = New-Object System.Windows.Forms.Button
    $Character_Import_Button.Location = "50,90"
    $Character_Import_Button.Size = "50,25"
    $Character_Import_Button.Text = "Import"
    $Character_Import_Button.add_Click({CharacterSelect})


    $Character_Select_Complete = New-Object System.windows.forms.Label
    $Character_Select_Complete.Size = "100,24"
    $Character_Select_Complete.Location = "200,78"
    $Character_Select_Complete.Text = "Party Chosen!"

    $Preset_Label = New-Object System.windows.forms.Label
    $Preset_Label.Size = "100,25"
    $Preset_Label.Location = "55,60"
    $Preset_Label.Text = "Presets!"
    $Preset_Label.Font = "Arial,10"

    $Preset_Standard = New-Object System.Windows.Forms.Button
    $Preset_Standard.Location = "30,80"
    $Preset_Standard.Size = "100,25"
    $Preset_Standard.Text = "Standard"
    $Preset_Standard.add_Click({StandardGame})

    $Preset_Beginner = New-Object System.Windows.Forms.Button
    $Preset_Beginner.Location = "30,110"
    $Preset_Beginner.Size = "100,25"
    $Preset_Beginner.Text = "Beginner"
    $Preset_Beginner.add_Click({BeginnerGame})

    $Preset_Balance = New-Object System.Windows.Forms.Button
    $Preset_Balance.Location = "30,140"
    $Preset_Balance.Size = "100,25"
    $Preset_Balance.Text = "Balance"
    $Preset_Balance.add_Click({BalanceGame})



     #region JOB Select Menu

    $Job_Mode_Button = New-Object System.Windows.Forms.Button
    $Job_Mode_Button.Text = "Job`nMode"
    $Job_Mode_Button.Size = "60,40"
    $Job_Mode_Button.Location = "20,120"
    $Job_Mode_Button.ADD_CLICK({JobMenu})

    $Job_Mode_Menu = New-object System.Windows.Forms.Form
    $Job_mode_Menu.Text = "JOB MENU"
    $Job_Mode_Menu.Size = "400,520"

    $Firion_Label = New-object System.Windows.Forms.Label
    $Firion_Label.Text = "Firion:"
    $Firion_Label.Size = "80,20"
    $Firion_Label.Location = "20,20"

    $Maria_Label = New-object System.Windows.Forms.Label
    $Maria_Label.Text = "Maria:"
    $Maria_Label.Size = "80,20"
    $Maria_Label.Location = "20,50"

    $Guy_Label = New-object System.Windows.Forms.Label
    $Guy_Label.Text = "Guy:"
    $Guy_Label.Size = "80,20"
    $Guy_Label.Location = "180,20"


    $Firion_Box = New-Object System.Windows.Forms.Textbox
    $firion_Box.Size = "60,20"
    $Firion_Box.Location = "100,20"

    $Maria_Box = New-Object System.Windows.Forms.Textbox
    $Maria_Box.Size = "60,20"
    $Maria_Box.Location = "100,50"

    $Guy_Box = New-Object System.Windows.Forms.Textbox
    $Guy_Box.Size = "60,20"
    $Guy_Box.Location = "260,20"


    $Import_Jobs = New-object System.windows.forms.Button
    $import_jobs.Text = "Import!"
    $import_Jobs.size = "60,32"
    $import_Jobs.Location = "200,50"
    $import_Jobs.ADD_CLICK({DetermineJobs})



    $Jobs_Label = New-object System.Windows.Forms.Label
    $Jobs_Label.Text = "White Mage (WHITE): `nSTR Low, AGI Low, VIT Mid, INT Low, SOL High, Staves Lv3, 2 Spells
    `nBlack Mage (BLACK): `nSTR Mid, AGI Low, VIT Low, INT High, SOL Low, Dirks Lv3, 2 Spells
    `nRed Mage (RED): `nSTR Mid, AGI Low, VIT Low, INT Mid, SOL Mid, Swords Lv2, 2 Spells
    `nBerserker (BSRK): `nSTR High, AGI Low, VIT High, INT Low, SOL Low, Axes Lv4, Haste
    `nDragoon (DRGN): `nSTR Mid, AGI Mid, VIT Mid, INT Low, SOL Low, Spears Lv3, No Magic
    `nPaladin (PLDN): `nSTR Mid, AGI Low, VIT Mid, INT Low, SOL Mid, Swords Lv2, 2 Spells
    `nHunter (HUNT): `nSTR Mid, AGI High, VIT Low, INT Low, SOL Low, Bows Lv3, 1 Spell
    `nMonk (MONK): `nSTR Mid, AGI Mid, VIT High, INT Low, SOL Low, Fists Lv3, No Magic
    `nWarrior (WARR): `nSTR Mid, AGI Mid, VIT Mid, INT Low, SOL Low, Swords Lv4, No Magic
    `nVanilla (VANN): `nStats go completely unaltered
    "
    $Jobs_Label.Size = "390,400"
    $Jobs_Label.Location = "10,100"

    #endregion JOB Select Menu


    <#

    $ToolStrip = New-Object System.Windows.Forms.ToolStrip

    $File_TS = New-Object System.Windows.Forms.ToolStripMenuItem
    $File_TS.Text = "File"

    $Open_FileTS = New-object System.Windows.Forms.ToolStripButton
    $Open_FileTS = "Open"
    $Open_FileTS.Add_click({})
    
    $ToolStrip.Items.Add($File_TS)
    
    $Main_Window.mainmenustrip = $ToolStrip

    $File_TS.DropDownItems.Add($Open_FileTS)
    
    
    #>




    #Kimochiwa

    $main_Window.Controls.Add($ToolStrip)
    $main_Window.Controls.Add($RandomizeButton)
    $main_Window.Controls.Add($BraggingRights)

    $main_Window.Controls.Add($TabControl)
    $main_Window.Controls.Add($Flaglist)
    $main_Window.Controls.Add($Preset_Standard)
    $main_Window.Controls.Add($Preset_Beginner)
    $main_Window.Controls.Add($Preset_Balance)
    $main_Window.Controls.Add($Preset_Label)
    

    $TabControl.Controls.Add($TabGamePage)
    $TabControl.Controls.Add($TabShopPage)
    $TabControl.Controls.Add($TabPlayerPage)
    $TabControl.Controls.Add($TabChaosPage)
    $TabControl.Controls.Add($TabOtherPage)

 


    $TabPlayerPage.Controls.Add($RandomizePlayerSprite)
    $TabPlayerPage.Controls.Add($RandomizePlayerHand)
    $TabPlayerPage.Controls.Add($RandomizePlayerStats)
    $TabPlayerPage.Controls.Add($PlayerSelectButton)

    $TabShopPage.Controls.Add($RandomizeShops)
    $TabShopPage.Controls.Add($TieredShops)

    $TabGamePage.Controls.Add($DoubleWalkSpeed)
    $TabGamePage.Controls.Add($RandomizeLootTable)
    $TabGamePage.Controls.Add($StartWithSpells)
    $TabGamePage.Controls.Add($CustomPlayerPal)
    $TabGamePage.Controls.Add($RandomizeTreasureChest)

    $TabChaosPage.Controls.Add($WeaponLock)
    $TabChaosPage.Controls.Add($SoloChallenge)
    #$TabChaosPage.Controls.Add($Job_Mode_Button)   Job mode nowhere close to being done

    $TabOtherPage.Controls.Add($MaxFirionStat)
    $TabOtherPage.Controls.Add($NoBloodSwords)
    $TabOtherPage.Controls.Add($NoStatDecrease)
    $TabOtherPage.Controls.Add($SpeedupMagicLV)

    $PartySelectMenu.Controls.Add($Player_Label)
    $PartySelectMenu.Controls.Add($Player1_Textbox)
    $PartySelectMenu.Controls.Add($Player2_Textbox)
    $PartySelectMenu.Controls.Add($Player3_Textbox)
    $PartySelectMenu.Controls.Add($Character_Import_Button)
    $PartySelectMenu.Controls.Add($Player_Tips)

    $Job_Mode_Menu.controls.Add($Firion_Label)
    $Job_Mode_Menu.controls.Add($Maria_Label)
    $Job_Mode_Menu.controls.Add($Guy_Label)
    $Job_Mode_Menu.controls.Add($Minwu_Label)
    $Job_Mode_Menu.controls.Add($Josef_Label)
    $Job_Mode_Menu.controls.Add($Gordon_Label)
    $Job_Mode_Menu.controls.Add($Layla_Label)
    $Job_Mode_Menu.controls.Add($Richard_Label)
    $Job_Mode_Menu.controls.Add($Jobs_Label)

    $Job_Mode_Menu.controls.Add($Firion_Box)
    $Job_Mode_Menu.controls.Add($Maria_Box)
    $Job_Mode_Menu.controls.Add($Guy_Box)

    $Job_Mode_Menu.controls.Add($Guy_Box)
    $Job_Mode_Menu.controls.Add($Import_Jobs)


    #asdassa
    $Main_window.ShowDialog()



}

Function PickParty {
$PartySelectMenu.ShowDialog()
}

Function JobMenu {
$Job_Mode_Menu.ShowDialog()
}


Function EvaluateRandomizer {

    LogFile 
    Dressup
    SetupAirship
        # keep good eye on order of operations!!!
    If ($RandomizeTreasureChest.Checked -eq $true) {RandomizeDungeonChest}
    If ($SoloChallenge.checked -eq $true) {KillTheParty}
    If ($RandomizeShops.checked -eq $true) {RandomizeShops}
    If ($TieredShops.checked -eq $true) {TieredShops}
    If ($RandomizePlayerStats.checked -eq $true) {RandomizeBaseStats}
    If ($RandomizePlayerHand.checked -eq $true) {RandomizeHands}
    If ($RandomizePlayerSprite.checked -eq $true) {RandomizeSprites}
    If ($StartWithSpells.checked -eq $true) {SpellSelect}
    If ($RandomizeLootTable.checked -eq $true) {RandomizeEnemyLoot}
    If ($WeaponLock.checked -eq $true) {LockWeaponType}
    If ($CustomPlayerPal.checked -eq $true) {CustomPlayerColor}
    IF ($DoubleWalkSpeed.checked -eq $true) {DoublePlayerSpeed}
    If ($MaxFirionStat.Checked -eq $true) {MaxOutStats}
    If ($NoBloodSwords.Checked -eq $true) {NoBloods}
    If ($NoStatDecrease.Checked -eq $true) {NoStatDown}
    If ($SpeedupMagicLV.Checked -eq $true) {MagicLVup}
    Write-Host "Imported" #Verify to console
    $main_Window.Controls.Add($Randocomplete)
    $PlayWav.playsync()
    




}


function StandardGame {

RandomizeSprites
RandomizeDungeonChest
RandomizeShops
CustomPlayerColor
DoublePlayerSpeed
RandomizeEnemyLoot
RandomizeBaseStats
NoBloods
    Dressup
    SetupAirship
    $main_Window.Controls.Add($Randocomplete)

}

function BeginnerGame {

RandomizeSprites
RandomizeDungeonChest
RandomizeShops
CustomPlayerColor
DoublePlayerSpeed
SpellSelect
RandomizeEnemyLoot
    Dressup
    SetupAirship
    $main_Window.Controls.Add($Randocomplete)

}

function BalanceGame {

RandomizeDungeonChest
TieredShops
RandomizeBaseStats
RandomizeSprites
SpellSelect
RandomizeEnemyLoot
CustomPlayerColor
DoublePlayerSpeed
    Dressup
    SetupAirship
    $main_Window.Controls.Add($Randocomplete)

}

Function TieredShops {





    #region altea

    $Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    
    
        #Altea Weapon Shop

    $Address = 0x3861D

    $RandomByte = $WeaponTier1 | Get-Random
    $HexValue = $RandomByte 
    $Romfile[$Address] = $HexValue
    
    $RandomByte = $WeaponTier1 | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+2] = $HexValue 
    
    $RandomByte = $WeaponTier1 | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+4] = $HexValue
    
    $RandomByte = $WeaponTier1 | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+6] = $HexValue

    [System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)

    
    
    
    $Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    

        #Altea Armor Shop

    $Address = 0x38625

    $RandomByte = $ArmorTier1 | Get-Random
    $HexValue = $RandomByte 
    $Romfile[$Address] = $HexValue
    
    $RandomByte = $ArmorTier1 | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+2] = $HexValue 
    
    $RandomByte = $ArmorTier1 | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+4] = $HexValue
    
    $RandomByte = $ArmorTier1 | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+6] = $HexValue





    [System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)


    $Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    

        #Altea Magic Shop

    $Address = 0x3862D

    $RandomByte = $SpellByteList | Get-Random
    $HexValue = $RandomByte 
    $Romfile[$Address] = $HexValue
    
    $RandomByte = $SpellByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+2] = $HexValue 
    
    $RandomByte = $SpellByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+4] = $HexValue
    
    $RandomByte = $SpellByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+6] = $HexValue





    [System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)


    $Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    

        #Altea MithrilWeapon Shop

    $Address = 0x38635

    $RandomByte = $WeaponByteList | Get-Random
    $HexValue = $RandomByte 
    $Romfile[$Address] = $HexValue
    
    $RandomByte = $WeaponByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+2] = $HexValue 
    
    $RandomByte = $WeaponByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+4] = $HexValue
    
    $RandomByte = $WeaponByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+6] = $HexValue





    [System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)

    


    $Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    

        #Altea MithrilArmor Shop

    $Address = 0x3863D

    $RandomByte = $ArmorByteList | Get-Random
    $HexValue = $RandomByte 
    $Romfile[$Address] = $HexValue
    
    $RandomByte = $ArmorByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+2] = $HexValue 
    
    $RandomByte = $ArmorByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+4] = $HexValue
    
    $RandomByte = $ArmorByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+6] = $HexValue


    [System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)

        #endregion altea




        #region Gatrea



    $Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    


        #Gatrea Weapon Shop

    $Address = 0x38645

    $RandomByte = $WeaponTier1 | Get-Random
    $HexValue = $RandomByte 
    $Romfile[$Address] = $HexValue
    
    $RandomByte = $WeaponTier1 | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+2] = $HexValue 
    
    $RandomByte = $WeaponTier1 | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+4] = $HexValue
    
    $RandomByte = $WeaponTier1 | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+6] = $HexValue


    [System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)




    $Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    


        #Gatrea Armor Shop

    $Address = 0x3864D

    $RandomByte = $ArmorTier1 | Get-Random
    $HexValue = $RandomByte 
    $Romfile[$Address] = $HexValue
    
    $RandomByte = $ArmorTier1 | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+2] = $HexValue 
    
    $RandomByte = $ArmorTier1 | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+4] = $HexValue
    
    $RandomByte = $ArmorTier1 | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+6] = $HexValue


    [System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)



    #endregion gatrea





        #region poft

        
    $Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    


        #Poft Weapon Shop

    $Address = 0x38655

    $RandomByte = $WeaponTier1 | Get-Random
    $HexValue = $RandomByte 
    $Romfile[$Address] = $HexValue
    
    $RandomByte = $WeaponTier1 | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+2] = $HexValue 
    
    $RandomByte = $WeaponTier1 | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+4] = $HexValue
    
    $RandomByte = $WeaponTier1 | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+6] = $HexValue


    [System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)



    $Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    


        #Poft Armor shop

    $Address = 0x3865D

    $RandomByte = $ArmorTier1 | Get-Random
    $HexValue = $RandomByte 
    $Romfile[$Address] = $HexValue
    
    $RandomByte = $ArmorTier1 | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+2] = $HexValue 
    
    $RandomByte = $ArmorTier1 | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+4] = $HexValue
    
    $RandomByte = $ArmorTier1 | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+6] = $HexValue


    [System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)



    $Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    


        #Poft Spell shop

    $Address = 0x38665

    $RandomByte = $SpellByteList | Get-Random
    $HexValue = $RandomByte 
    $Romfile[$Address] = $HexValue
    
    $RandomByte = $SpellByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+2] = $HexValue 
    
    $RandomByte = $SpellByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+4] = $HexValue
    
    $RandomByte = $SpellByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+6] = $HexValue


    [System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)


        #endregion poft


        #region Salamand




    $Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    


        #Salamand Weapon Shop

    $Address = 0x38675

    $RandomByte = $WeaponTier2 | Get-Random
    $HexValue = $RandomByte 
    $Romfile[$Address] = $HexValue
    
    $RandomByte = $WeaponTier2 | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+2] = $HexValue 
    
    $RandomByte = $WeaponTier2 | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+4] = $HexValue
    
    $RandomByte = $WeaponTier2 | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+6] = $HexValue


    [System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)



    $Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    


        #Salamand Armor shop

    $Address = 0x3867D

    $RandomByte = $ArmorTier2 | Get-Random
    $HexValue = $RandomByte 
    $Romfile[$Address] = $HexValue
    
    $RandomByte = $ArmorTier2 | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+2] = $HexValue 
    
    $RandomByte = $ArmorTier2 | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+4] = $HexValue
    
    $RandomByte = $ArmorTier2 | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+6] = $HexValue


    [System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)



    $Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    


        #Salamand Spell shop

    $Address = 0x38685

    $RandomByte = $SpellByteList | Get-Random
    $HexValue = $RandomByte 
    $Romfile[$Address] = $HexValue
    
    $RandomByte = $SpellByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+2] = $HexValue 
    
    $RandomByte = $SpellByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+4] = $HexValue
    
    $RandomByte = $SpellByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+6] = $HexValue


    [System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)




        #endregion Salamand



        #region Bafsk


    
    $Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    


        #Bafsk Weapon Shop

    $Address = 0x3868D

    $RandomByte = $WeaponTier2 | Get-Random
    $HexValue = $RandomByte 
    $Romfile[$Address] = $HexValue
    
    $RandomByte = $WeaponTier2 | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+2] = $HexValue 
    
    $RandomByte = $WeaponTier2 | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+4] = $HexValue
    
    $RandomByte = $WeaponTier2 | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+6] = $HexValue


    [System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)



    $Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    


        #Bafsk Armor shop

    $Address = 0x38695

    $RandomByte = $ArmorTier2 | Get-Random
    $HexValue = $RandomByte 
    $Romfile[$Address] = $HexValue
    
    $RandomByte = $ArmorTier2 | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+2] = $HexValue 
    
    $RandomByte = $ArmorTier2 | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+4] = $HexValue
    
    $RandomByte = $ArmorTier2 | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+6] = $HexValue


    [System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)



    $Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    


        #Bafsk Spell shop

    $Address = 0x3869D

    $RandomByte = $SpellByteList | Get-Random
    $HexValue = $RandomByte 
    $Romfile[$Address] = $HexValue
    
    $RandomByte = $SpellByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+2] = $HexValue 
    
    $RandomByte = $SpellByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+4] = $HexValue
    
    $RandomByte = $SpellByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+6] = $HexValue


    [System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)





        #endregion Bafsk


         #region Phin

        
        
    
    $Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    


        #Phin Weapon Shop

    $Address = 0x386A5

    $RandomByte = $WeaponTier3 | Get-Random
    $HexValue = $RandomByte 
    $Romfile[$Address] = $HexValue
    
    $RandomByte = $WeaponTier3 | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+2] = $HexValue 
    
    $RandomByte = $WeaponTier3 | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+4] = $HexValue
    
    $RandomByte = $WeaponByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+6] = $HexValue


    [System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)



    $Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    


        #Phin Armor shop

    $Address = 0x386AD

    $RandomByte = $ArmorTier3 | Get-Random
    $HexValue = $RandomByte 
    $Romfile[$Address] = $HexValue
    
    $RandomByte = $ArmorTier3 | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+2] = $HexValue 
    
    $RandomByte = $ArmorTier3 | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+4] = $HexValue
    
    $RandomByte = $ArmorTier3 | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+6] = $HexValue


    [System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)



    $Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    


        #Phin Spell shop

    $Address = 0x386B5

    $RandomByte = $SpellByteList | Get-Random
    $HexValue = $RandomByte 
    $Romfile[$Address] = $HexValue
    
    $RandomByte = $SpellByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+2] = $HexValue 
    
    $RandomByte = $SpellByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+4] = $HexValue
    
    $RandomByte = $SpellByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+6] = $HexValue


    [System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)
                 


        #endregion Phin

        #region MYSIDIA

        
        
    
    $Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    


        #Mysidia Weapon Shop

    $Address = 0x386BD

    $RandomByte = $WeaponTier3 | Get-Random
    $HexValue = $RandomByte 
    $Romfile[$Address] = $HexValue
    
    $RandomByte = $WeaponTier3 | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+2] = $HexValue 
    
    $RandomByte = $WeaponTier3 | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+4] = $HexValue
    
    $RandomByte = $WeaponTier3 | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+6] = $HexValue


    [System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)



    $Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    


        #Mysidia Armor shop

    $Address = 0x386C5

    $RandomByte = $ArmorTier3 | Get-Random
    $HexValue = $RandomByte 
    $Romfile[$Address] = $HexValue
    
    $RandomByte = $ArmorTier3 | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+2] = $HexValue 
    
    $RandomByte = $ArmorTier4 | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+4] = $HexValue
    
    $RandomByte = $ArmorTier4 | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+6] = $HexValue


    [System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)



    $Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    


        #Mysidia Spell shop

    $Address = 0x386CD

    $RandomByte = $SpellByteList | Get-Random
    $HexValue = $RandomByte 
    $Romfile[$Address] = $HexValue
    
    $RandomByte = $SpellByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+2] = $HexValue 
    
    $RandomByte = $SpellByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+4] = $HexValue
    
    $RandomByte = $SpellByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+6] = $HexValue


    [System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)
                 


        #endregion MYSIDIA


        #region Jamaica


         $Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    


        #Jamica Random Shop

            $Address = 0x386D5

         $RandomByte = $WeaponTier4 | Get-Random
         $HexValue = $RandomByte 
         $Romfile[$Address] = $HexValue
    
         $RandomByte = $WeaponTier4 | Get-Random
         $HexValue = $RandomByte
         $Romfile[$Address+2] = $HexValue 
          
         $RandomByte = $ArmorTier4 | Get-Random
         $HexValue = $RandomByte
         $Romfile[$Address+4] = $HexValue
    
         $RandomByte = $ArmorTier4 | Get-Random
         $HexValue = $RandomByte
         $Romfile[$Address+6] = $HexValue

    #endregion Jamaica


        $main_Window.Controls.Add($Tiered_Shops_Complete)


        Add-Content -Path "$Currentdir\Spoilers.Txt" -Value " TS"


}




Function RandomizeShops {

     
        #disables life spell if solo challange is on 
    If ($SoloChallenge.checked -eq $true) {
    
    
    }



    #region altea

    $Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    
    
        #Altea Weapon Shop

    $Address = 0x3861D

    $RandomByte = $WeaponByteList | Get-Random
    $HexValue = $RandomByte 
    $Romfile[$Address] = $HexValue
    
    $RandomByte = $WeaponByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+2] = $HexValue 
    
    $RandomByte = $WeaponByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+4] = $HexValue
    
    $RandomByte = $WeaponByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+6] = $HexValue

    [System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)

    
    
    
    $Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    

        #Altea Armor Shop

    $Address = 0x38625

    $RandomByte = $ArmorByteList | Get-Random
    $HexValue = $RandomByte 
    $Romfile[$Address] = $HexValue
    
    $RandomByte = $ArmorByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+2] = $HexValue 
    
    $RandomByte = $ArmorByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+4] = $HexValue
    
    $RandomByte = $ArmorByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+6] = $HexValue





    [System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)


    $Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    

        #Altea Magic Shop

    $Address = 0x3862D

    $RandomByte = $SpellByteList | Get-Random
    $HexValue = $RandomByte 
    $Romfile[$Address] = $HexValue
    
    $RandomByte = $SpellByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+2] = $HexValue 
    
    $RandomByte = $SpellByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+4] = $HexValue
    
    $RandomByte = $SpellByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+6] = $HexValue





    [System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)


    $Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    

        #Altea MithrilWeapon Shop

    $Address = 0x38635

    $RandomByte = $WeaponByteList | Get-Random
    $HexValue = $RandomByte 
    $Romfile[$Address] = $HexValue
    
    $RandomByte = $WeaponByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+2] = $HexValue 
    
    $RandomByte = $WeaponByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+4] = $HexValue
    
    $RandomByte = $WeaponByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+6] = $HexValue





    [System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)

    


    $Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    

        #Altea MithrilArmor Shop

    $Address = 0x3863D

    $RandomByte = $ArmorByteList | Get-Random
    $HexValue = $RandomByte 
    $Romfile[$Address] = $HexValue
    
    $RandomByte = $ArmorByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+2] = $HexValue 
    
    $RandomByte = $ArmorByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+4] = $HexValue
    
    $RandomByte = $ArmorByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+6] = $HexValue


    [System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)

        #endregion altea




        #region Gatrea



    $Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    


        #Gatrea Weapon Shop

    $Address = 0x38645

    $RandomByte = $WeaponByteList | Get-Random
    $HexValue = $RandomByte 
    $Romfile[$Address] = $HexValue
    
    $RandomByte = $WeaponByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+2] = $HexValue 
    
    $RandomByte = $WeaponByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+4] = $HexValue
    
    $RandomByte = $WeaponByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+6] = $HexValue


    [System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)




    $Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    


        #Gatrea Armor Shop

    $Address = 0x3864D

    $RandomByte = $ArmorByteList | Get-Random
    $HexValue = $RandomByte 
    $Romfile[$Address] = $HexValue
    
    $RandomByte = $ArmorByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+2] = $HexValue 
    
    $RandomByte = $ArmorByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+4] = $HexValue
    
    $RandomByte = $ArmorByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+6] = $HexValue


    [System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)



    #endregion gatrea





        #region poft

        
    $Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    


        #Poft Weapon Shop

    $Address = 0x38655

    $RandomByte = $WeaponByteList | Get-Random
    $HexValue = $RandomByte 
    $Romfile[$Address] = $HexValue
    
    $RandomByte = $WeaponByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+2] = $HexValue 
    
    $RandomByte = $WeaponByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+4] = $HexValue
    
    $RandomByte = $WeaponByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+6] = $HexValue


    [System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)



    $Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    


        #Poft Armor shop

    $Address = 0x3865D

    $RandomByte = $ArmorByteList | Get-Random
    $HexValue = $RandomByte 
    $Romfile[$Address] = $HexValue
    
    $RandomByte = $ArmorByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+2] = $HexValue 
    
    $RandomByte = $ArmorByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+4] = $HexValue
    
    $RandomByte = $ArmorByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+6] = $HexValue


    [System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)



    $Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    


        #Poft Spell shop

    $Address = 0x38665

    $RandomByte = $SpellByteList | Get-Random
    $HexValue = $RandomByte 
    $Romfile[$Address] = $HexValue
    
    $RandomByte = $SpellByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+2] = $HexValue 
    
    $RandomByte = $SpellByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+4] = $HexValue
    
    $RandomByte = $SpellByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+6] = $HexValue


    [System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)


        #endregion poft


        #region Salamand




    $Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    


        #Salamand Weapon Shop

    $Address = 0x38675

    $RandomByte = $WeaponByteList | Get-Random
    $HexValue = $RandomByte 
    $Romfile[$Address] = $HexValue
    
    $RandomByte = $WeaponByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+2] = $HexValue 
    
    $RandomByte = $WeaponByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+4] = $HexValue
    
    $RandomByte = $WeaponByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+6] = $HexValue


    [System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)



    $Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    


        #Salamand Armor shop

    $Address = 0x3867D

    $RandomByte = $ArmorByteList | Get-Random
    $HexValue = $RandomByte 
    $Romfile[$Address] = $HexValue
    
    $RandomByte = $ArmorByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+2] = $HexValue 
    
    $RandomByte = $ArmorByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+4] = $HexValue
    
    $RandomByte = $ArmorByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+6] = $HexValue


    [System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)



    $Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    


        #Salamand Spell shop

    $Address = 0x38685

    $RandomByte = $SpellByteList | Get-Random
    $HexValue = $RandomByte 
    $Romfile[$Address] = $HexValue
    
    $RandomByte = $SpellByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+2] = $HexValue 
    
    $RandomByte = $SpellByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+4] = $HexValue
    
    $RandomByte = $SpellByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+6] = $HexValue


    [System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)




        #endregion Salamand



        #region Bafsk


    
    $Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    


        #Bafsk Weapon Shop

    $Address = 0x3868D

    $RandomByte = $WeaponByteList | Get-Random
    $HexValue = $RandomByte 
    $Romfile[$Address] = $HexValue
    
    $RandomByte = $WeaponByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+2] = $HexValue 
    
    $RandomByte = $WeaponByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+4] = $HexValue
    
    $RandomByte = $WeaponByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+6] = $HexValue


    [System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)



    $Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    


        #Bafsk Armor shop

    $Address = 0x38695

    $RandomByte = $ArmorByteList | Get-Random
    $HexValue = $RandomByte 
    $Romfile[$Address] = $HexValue
    
    $RandomByte = $ArmorByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+2] = $HexValue 
    
    $RandomByte = $ArmorByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+4] = $HexValue
    
    $RandomByte = $ArmorByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+6] = $HexValue


    [System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)



    $Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    


        #Bafsk Spell shop

    $Address = 0x3869D

    $RandomByte = $SpellByteList | Get-Random
    $HexValue = $RandomByte 
    $Romfile[$Address] = $HexValue
    
    $RandomByte = $SpellByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+2] = $HexValue 
    
    $RandomByte = $SpellByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+4] = $HexValue
    
    $RandomByte = $SpellByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+6] = $HexValue


    [System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)





        #endregion Bafsk


         #region Phin

        
        
    
    $Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    


        #Phin Weapon Shop

    $Address = 0x386A5

    $RandomByte = $WeaponByteList | Get-Random
    $HexValue = $RandomByte 
    $Romfile[$Address] = $HexValue
    
    $RandomByte = $WeaponByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+2] = $HexValue 
    
    $RandomByte = $WeaponByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+4] = $HexValue
    
    $RandomByte = $WeaponByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+6] = $HexValue


    [System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)



    $Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    


        #Phin Armor shop

    $Address = 0x386AD

    $RandomByte = $ArmorByteList | Get-Random
    $HexValue = $RandomByte 
    $Romfile[$Address] = $HexValue
    
    $RandomByte = $ArmorByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+2] = $HexValue 
    
    $RandomByte = $ArmorByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+4] = $HexValue
    
    $RandomByte = $ArmorByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+6] = $HexValue


    [System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)



    $Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    


        #Phin Spell shop

    $Address = 0x386B5

    $RandomByte = $SpellByteList | Get-Random
    $HexValue = $RandomByte 
    $Romfile[$Address] = $HexValue
    
    $RandomByte = $SpellByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+2] = $HexValue 
    
    $RandomByte = $SpellByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+4] = $HexValue
    
    $RandomByte = $SpellByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+6] = $HexValue


    [System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)
                 


        #endregion Phin

        #region MYSIDIA

        
        
    
    $Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    


        #Mysidia Weapon Shop

    $Address = 0x386BD

    $RandomByte = $WeaponByteList | Get-Random
    $HexValue = $RandomByte 
    $Romfile[$Address] = $HexValue
    
    $RandomByte = $WeaponByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+2] = $HexValue 
    
    $RandomByte = $WeaponByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+4] = $HexValue
    
    $RandomByte = $WeaponByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+6] = $HexValue


    [System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)



    $Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    


        #Mysidia Armor shop

    $Address = 0x386C5

    $RandomByte = $ArmorByteList | Get-Random
    $HexValue = $RandomByte 
    $Romfile[$Address] = $HexValue
    
    $RandomByte = $ArmorByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+2] = $HexValue 
    
    $RandomByte = $ArmorByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+4] = $HexValue
    
    $RandomByte = $ArmorByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+6] = $HexValue


    [System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)



    $Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    


        #Mysidia Spell shop

    $Address = 0x386CD

    $RandomByte = $SpellByteList | Get-Random
    $HexValue = $RandomByte 
    $Romfile[$Address] = $HexValue
    
    $RandomByte = $SpellByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+2] = $HexValue 
    
    $RandomByte = $SpellByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+4] = $HexValue
    
    $RandomByte = $SpellByteList | Get-Random
    $HexValue = $RandomByte
    $Romfile[$Address+6] = $HexValue


    [System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)
                 


        #endregion MYSIDIA


        #region Jamaica


         $Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    


        #Jamica Random Shop

            $Address = 0x386D5

         $RandomByte = $WeaponByteList | Get-Random
         $HexValue = $RandomByte 
         $Romfile[$Address] = $HexValue
    
         $RandomByte = $WeaponByteList | Get-Random
         $HexValue = $RandomByte
         $Romfile[$Address+2] = $HexValue 
          
         $RandomByte = $ArmorByteList | Get-Random
         $HexValue = $RandomByte
         $Romfile[$Address+4] = $HexValue
    
         $RandomByte = $ArmorByteList | Get-Random
         $HexValue = $RandomByte
         $Romfile[$Address+6] = $HexValue

    #endregion Jamaica


    [System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)


        $main_Window.Controls.Add($Randomize_Shops_Complete)

        Add-Content -Path "$Currentdir\Spoilers.Txt" -Value " RS"

}



Function RandomizeHands {

$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    
    
        #Firion Hands

    $Address = 0xF90

    $RandomByte = $FirionHandList | Get-Random
    $HexValue = $RandomByte 
    $Romfile[$Address] = $HexValue

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)


$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    
    
        #Maria Hands

    $Address = 0x1010

    $RandomByte = $MariaHandList | Get-Random
    $HexValue = $RandomByte 
    $Romfile[$Address] = $HexValue

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)


$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    
    
        #Guy Hands

    $Address = 0x1090

    $RandomByte = $GuyHandList | Get-Random
    $HexValue = $RandomByte 
    $Romfile[$Address] = $HexValue

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)

$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    
    
        #Minwu Hands

    $Address = 0x1110

    $RandomByte = $MinwuHandList | Get-Random
    $HexValue = $RandomByte 
    $Romfile[$Address] = $HexValue

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)

$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    
    
        #Josef Hands

    $Address = 0x1190

    $RandomByte = $JosefHandList | Get-Random
    $HexValue = $RandomByte 
    $Romfile[$Address] = $HexValue

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)



$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    
    
        #Gordon Hands

    $Address = 0x1210

    $RandomByte = $GordonHandList | Get-Random
    $HexValue = $RandomByte 
    $Romfile[$Address] = $HexValue

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)



$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    
    
        #Layla Hands

    $Address = 0x1290

    $RandomByte = $LaylaHandList | Get-Random
    $HexValue = $RandomByte 
    $Romfile[$Address] = $HexValue

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)


$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    
    
        #Richard Hands

    $Address = 0x1310

    $RandomByte = $RichardHandList | Get-Random
    $HexValue = $RandomByte 
    $Romfile[$Address] = $HexValue

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)




$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    
    
        #Leon Hands

    $Address = 0x1390

    $RandomByte = $LeonHandList | Get-Random
    $HexValue = $RandomByte 
    $Romfile[$Address] = $HexValue

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)




    $Main_window.Controls.Add($Randomize_Dominant_Hand_Complete)  #does this do anything


    Add-Content -Path "$Currentdir\Spoilers.Txt" -Value " RH"

}




function RandomizeSprites {

    Write-Host "====Players=Sprites===="

    $FirionSprite = $RandomPlayerSprite | Get-Random

    Write-Host "Firion OK"

    $MariaSprite = $RandomPlayerSprite | Get-Random
    While ($MariaSprite -eq $FirionSprite) {$MariaSprite = $RandomPlayerSprite | Get-Random}

    Write-Host "Maria OK"

    $GuySprite = $RandomPlayerSprite | Get-Random
    While ($GuySprite -eq $FirionSprite) {
            While ($GuySprite = $MariaSprite) {
                $GuySprite = $RandomPlayerSprite | Get-Random
            }
        }

    Write-Host "Guy OK"

    $MinwuSprite = $RandomPlayerSprite | Get-Random
    While ($MinwuSprite -eq $FirionSprite) {
        While ($MinwuSprite -eq $MariaSprite) {
            While ($MinwuSprite -eq $GuySprite) {
            $MinwuSprite = $RandomPlayerSprite | Get-Random        
            }        
        }
    }

    Write-Host "Minwu OK"

    $JosefSprite = $RandomPlayerSprite | Get-Random
    While ($JosefSprite -eq $FirionSprite) {
        While ($JosefSprite -eq $MariaSprite) {
            While ($JosefSprite -eq $GuySprite) {
                While ($JosefSprite -eq $MinwuSprite) {
                $JosefSprite = $RandomPlayerSprite | Get-Random        
                }        
            }
        }
    } 

    Write-Host "Josef OK"

    $GordonSprite = $RandomPlayerSprite | Get-Random
    While ($GordonSprite -eq $FirionSprite) {
        While ($GordonSprite -eq $MariaSprite) {
            While ($GordonSprite -eq $GuySprite) {
                While ($GordonSprite -eq $MinwuSprite) {
                    While ($GordonSprite -eq $JosefSprite) {
                        $GordonSprite = $RandomPlayerSprite | Get-Random  
                     }      
                }        
            }
        }
    } 


    Write-Host "Gordon OK"

    $LaylaSprite = $RandomPlayerSprite | Get-Random
    While ($LaylaSprite -eq $FirionSprite) {
        While ($LaylaSprite -eq $MariaSprite) {
            While ($LaylaSprite -eq $GuySprite) {
                While ($LaylaSprite -eq $MinwuSprite) {
                    While ($LaylaSprite -eq $JosefSprite) {
                        While ($LaylaSprite -eq $GordonSprite) {
                            $LaylaSprite = $RandomPlayerSprite | Get-Random  
                        }
                     }      
                }        
            }
        }
    } 


    Write-Host "Layla OK"

     $RichardSprite = $RandomPlayerSprite | Get-Random
    While ($RichardSprite -eq $FirionSprite) {
        While ($RichardSprite -eq $MariaSprite) {
            While ($RichardSprite -eq $GuySprite) {
                While ($RichardSprite -eq $MinwuSprite) {
                    While ($RichardSprite -eq $JosefSprite) {
                        While ($RichardSprite -eq $GordonSprite) {
                            While ($RichardSprite -eq $LaylaSprite) {
                                $RichardSprite = $RandomPlayerSprite | Get-Random  
                            }
                        }
                     }      
                }        
            }
        }
    } 
    

    Write-Host "Richard OK"

    $LeonSprite = $RandomPlayerSprite | Get-Random
    While ($LeonSprite -eq $FirionSprite) {
        While ($LeonSprite -eq $MariaSprite) {
            While ($LeonSprite -eq $GuySprite) {
                While ($LeonSprite -eq $MinwuSprite) {
                    While ($LeonSprite -eq $JosefSprite) {
                        While ($LeonSprite -eq $GordonSprite) {
                            While ($LeonSprite -eq $LaylaSprite) {
                                While ($LeonSprite -eq $RichardSprite) {
                                    $LeonSprite = $RandomPlayerSprite | Get-Random  
                                }
                            }
                        }
                     }      
                }        
            }
        }
    } 

    Write-Host "Leon OK"

$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    
    
        #Firion 

    $Address = 0xF90


    $HexValue = $FirionSprite 
    $Romfile[$Address] = $HexValue

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)


$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    
    
        #Maria 

    $Address = 0x1010


    $HexValue = $MariaSprite 
    $Romfile[$Address] = $HexValue

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)


$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    
    
        #Guy 

    $Address = 0x1090


    $HexValue = $GuySprite 
    $Romfile[$Address] = $HexValue

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)


$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    
    
        #Minwu 

    $Address = 0x1110


    $HexValue = $MinwuSprite 
    $Romfile[$Address] = $HexValue

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)


$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    
    
        #Josef 

    $Address = 0x1190


    $HexValue = $JosefSprite 
    $Romfile[$Address] = $HexValue

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)



$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    
    
        #Gordon 

    $Address = 0x1210


    $HexValue = $GordonSprite 
    $Romfile[$Address] = $HexValue

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)


$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    
    
        #Layla 

    $Address = 0x1290


    $HexValue = $LaylaSprite 
    $Romfile[$Address] = $HexValue

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)



$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    
    
        #Richard 

    $Address = 0x1310


    $HexValue = $RichardSprite 
    $Romfile[$Address] = $HexValue

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)


$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    
    
        #Leon 

    $Address = 0x1390


    $HexValue = $LeonSprite 
    $Romfile[$Address] = $HexValue

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)






$main_window.Controls.Add($Randomize_Player_Sprite_Complete)


Add-Content -Path "$Currentdir\Spoilers.Txt" -Value " RC"

}



function RandomizeBaseStats {


    #region Firion 

$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    
    
        #Firion HP 

    $RandomizedBaseHP = $RandomBaseHP | Get-Random
    $Address = 0xF98    # current
    $HexValue = $RandomizedBaseHP
    $Romfile[$Address] = $HexValue 

    $Address = 0xF9A    # Max
    $HexValue = $RandomizedBaseHP
    $Romfile[$Address] = $HexValue 

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)


 

$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    
    
        #Firion Attack 


    $RandomizedBaseStat = $RandomBaseStat | Get-Random
    $Address = 0xFA0
    $HexValue = $RandomizedBaseStat
    $Romfile[$Address] = $HexValue

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)


$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    
    
        #Firion Agility 
    $RandomizedBaseStat = $RandomBaseStat | Get-Random
    $Address = 0xFA1
    $HexValue = $RandomizedBaseStat
    $Romfile[$Address] = $HexValue

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)


$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    
    
        #Firion Vitality 
    $RandomizedBaseStat = $RandomBaseStat | Get-Random
    $Address = 0xFA2
    $HexValue = $RandomizedBaseStat
    $Romfile[$Address] = $HexValue

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)


$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    
    
        #Firion Intelligence 
    $RandomizedBaseStat = $RandomBaseStat | Get-Random
    $Address = 0xFA3
    $HexValue = $RandomizedBaseStat
    $Romfile[$Address] = $HexValue

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)


$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    
    
        #Firion Soul 
    $RandomizedBaseStat = $RandomBaseStat | Get-Random
    $Address = 0xFA4
    $HexValue = $RandomizedBaseStat
    $Romfile[$Address] = $HexValue

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)

    $main_Window.controls.Add($Randomize_Base_Stats_Complete)



    #endregion Firion



    #region Maria

    $Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    
    
        #Maria HP 

    $RandomizedBaseHP = $RandomBaseHP | Get-Random
    $Address = 0x1018    # current
    $HexValue = $RandomizedBaseHP
    $Romfile[$Address] = $HexValue 

    $Address = 0x101A    # Max
    $HexValue = $RandomizedBaseHP
    $Romfile[$Address] = $HexValue 

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)


 

$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    
    
        #Maria Attack 


    $RandomizedBaseStat = $RandomBaseStat | Get-Random
    $Address = 0x1020
    $HexValue = $RandomizedBaseStat
    $Romfile[$Address] = $HexValue

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)


$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    
    
        #Maria Agility 
    $RandomizedBaseStat = $RandomBaseStat | Get-Random
    $Address = 0x1021
    $HexValue = $RandomizedBaseStat
    $Romfile[$Address] = $HexValue

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)


$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    
    
        #Maria Vitality 
    $RandomizedBaseStat = $RandomBaseStat | Get-Random
    $Address = 0x1022
    $HexValue = $RandomizedBaseStat
    $Romfile[$Address] = $HexValue

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)


$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    
    
        #Maria Intelligence 
    $RandomizedBaseStat = $RandomBaseStat | Get-Random
    $Address = 0x1023
    $HexValue = $RandomizedBaseStat
    $Romfile[$Address] = $HexValue

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)


$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    
    
        #Maria Soul 
    $RandomizedBaseStat = $RandomBaseStat | Get-Random
    $Address = 0x1024
    $HexValue = $RandomizedBaseStat
    $Romfile[$Address] = $HexValue

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)

    $main_Window.controls.Add($Randomize_Base_Stats_Complete)


    #endregion Maria



    #region Guy

    
    $Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    
    
        #Guy HP 

    $RandomizedBaseHP = $RandomBaseHP | Get-Random
    $Address = 0x1098    # current
    $HexValue = $RandomizedBaseHP
    $Romfile[$Address] = $HexValue 

    $Address = 0x109A    # Max
    $HexValue = $RandomizedBaseHP
    $Romfile[$Address] = $HexValue 

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)


 

$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    
    
        #Guy Attack 


    $RandomizedBaseStat = $RandomBaseStat | Get-Random
    $Address = 0x10A0
    $HexValue = $RandomizedBaseStat
    $Romfile[$Address] = $HexValue

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)


$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    
    
        #Guy Agility 
    $RandomizedBaseStat = $RandomBaseStat | Get-Random
    $Address = 0x10A1
    $HexValue = $RandomizedBaseStat
    $Romfile[$Address] = $HexValue

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)


$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    
    
        #Guy Vitality 
    $RandomizedBaseStat = $RandomBaseStat | Get-Random
    $Address = 0x10A2
    $HexValue = $RandomizedBaseStat
    $Romfile[$Address] = $HexValue

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)


$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    
    
        #Guy Intelligence 
    $RandomizedBaseStat = $RandomBaseStat | Get-Random
    $Address = 0x10A3
    $HexValue = $RandomizedBaseStat
    $Romfile[$Address] = $HexValue

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)


$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    
    
        #Guy Soul 
    $RandomizedBaseStat = $RandomBaseStat | Get-Random
    $Address = 0x10A4
    $HexValue = $RandomizedBaseStat
    $Romfile[$Address] = $HexValue

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)

    $main_Window.controls.Add($Randomize_Base_Stats_Complete)



    #endregion Guy

    Add-Content -Path "$Currentdir\Spoilers.Txt" -Value " BS"


}


function CharacterSelect {

    
$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    
    
        #Player1 


    $Address = 0xF90    # current
    $HexValue = $Player1_Textbox.Text
    $Romfile[$Address] = $HexValue 

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)




$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    
    
        #Player2 


    $Address = 0x1010    # current
    $HexValue = $Player2_Textbox.Text
    $Romfile[$Address] = $HexValue 

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)




$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    
    
        #Player3 


    $Address = 0x1090    # current
    $HexValue = $Player3_Textbox.Text
    $Romfile[$Address] = $HexValue 

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)


    $main_window.Controls.Add($Character_Select_Complete)

}


function SpellSelect {

                # # # Firion # # #

$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    
    
        #Spell 1 


    $Address = 0xFC0    # current
    $HexValue = $MagicByteList | Get-Random
    $Romfile[$Address] = $HexValue 

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)

$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    
    
        # Spell 2 


    $Address = 0xFC1    # current
    $HexValue = $MagicByteList | Get-Random
    $Romfile[$Address] = $HexValue 

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)


                # # # Maria # # #

$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    
    
                # Spell 1 


    $Address = 0x1040    # current
    $HexValue = $MagicByteList | Get-Random
    $Romfile[$Address] = $HexValue 

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)

$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    
    
               # Spell 2 


    $Address = 0x1041    # current
    $HexValue = $MagicByteList | Get-Random
    $Romfile[$Address] = $HexValue 

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)


                # # # Guy # # #

$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    
    
        #Spell 1 


    $Address = 0x10C0    # current
    $HexValue = $MagicByteList | Get-Random
    $Romfile[$Address] = $HexValue 

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)

$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    
    
        #Spell 2 


    $Address = 0x10C1    # current
    $HexValue = $MagicByteList | Get-Random
    $Romfile[$Address] = $HexValue 

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)


                # # # Minwu # # #

$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    
    
                # Spell 1 


    $Address = 0x1140    # current
    $HexValue = $MagicByteList | Get-Random
    $Romfile[$Address] = $HexValue 

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)

$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    
    
               # Spell 2 


    $Address = 0x1141    # current
    $HexValue = $MagicByteList | Get-Random
    $Romfile[$Address] = $HexValue 

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)


                # # # Josef # # #

$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    
    
        #Spell 1 


    $Address = 0x11C0    # current
    $HexValue = $MagicByteList | Get-Random
    $Romfile[$Address] = $HexValue 

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)

$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    
    
        #Spell 2 


    $Address = 0x11C1    # current
    $HexValue = $MagicByteList | Get-Random
    $Romfile[$Address] = $HexValue 

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)



                # # # Gordon # # #

$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    
    
                # Spell 1 


    $Address = 0x1240    # current
    $HexValue = $MagicByteList | Get-Random
    $Romfile[$Address] = $HexValue 

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)

$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    
    
               # Spell 2 


    $Address = 0x1241    # current
    $HexValue = $MagicByteList | Get-Random
    $Romfile[$Address] = $HexValue 

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)



               # # # Layla # # #

$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    
    
        #Spell 1 


    $Address = 0x12C0    # current
    $HexValue = $MagicByteList | Get-Random
    $Romfile[$Address] = $HexValue 

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)

$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    
    
        #Spell 2 


    $Address = 0x12C1    # current
    $HexValue = $MagicByteList | Get-Random
    $Romfile[$Address] = $HexValue 

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)



               # # # Richard # # #

$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    
    
                # Spell 1 


    $Address = 0x1340    # current
    $HexValue = $MagicByteList | Get-Random
    $Romfile[$Address] = $HexValue 

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)

$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    
    
               # Spell 2 


    $Address = 0x1341    # current
    $HexValue = $MagicByteList | Get-Random
    $Romfile[$Address] = $HexValue 

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)


               # # # Leon # # #

$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    
    
        #Spell 1 


    $Address = 0x13C0    # current
    $HexValue = $MagicByteList | Get-Random
    $Romfile[$Address] = $HexValue 

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)

$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    
    
        #Spell 2 


    $Address = 0x13C1    # current
    $HexValue = $MagicByteList | Get-Random
    $Romfile[$Address] = $HexValue 

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)


    Add-Content -Path "$Currentdir\Spoilers.Txt" -Value " 2S"

}


function RandomizeEnemyLoot {

    
       
       
$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    
    
   

$Address = 0x17810    # current
    
    While ($Address -le 0x179EF) {
    $HexValue = $TreasureByteList | Get-Random
    $Romfile[$Address] = $HexValue 
    $Address++ 

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)
       
       }

    Add-Content -Path "$Currentdir\Spoilers.Txt" -Value " RL"

}


function LockWeaponType {
    
    
        #This sets all weapon Mastery to 0 on all players, all WeaponTypes


    #Firion

$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")


    $Address = 0xFD0
    $HexValue = 0x0
    $Romfile[$Address] = $HexValue 
    $Romfile[$Address+1] = $HexValue 
    $Romfile[$Address+2] = $HexValue 
    $Romfile[$Address+3] = $HexValue 
    $Romfile[$Address+4] = $HexValue 
    $Romfile[$Address+5] = $HexValue 
    $Romfile[$Address+6] = $HexValue 
    $Romfile[$Address+7] = $HexValue 
    $Romfile[$Address+8] = $HexValue 
    $Romfile[$Address+9] = $HexValue 
    $Romfile[$Address+10] = $HexValue 
    $Romfile[$Address+11] = $HexValue 
    $Romfile[$Address+12] = $HexValue 
    $Romfile[$Address+13] = $HexValue 
    $Romfile[$Address+14] = $HexValue 
    $Romfile[$Address+15] = $HexValue 


[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)



    #Maria

$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")


    $Address = 0x1050
    $HexValue = 0x0
    $Romfile[$Address] = $HexValue 
    $Romfile[$Address+1] = $HexValue 
    $Romfile[$Address+2] = $HexValue 
    $Romfile[$Address+3] = $HexValue 
    $Romfile[$Address+4] = $HexValue 
    $Romfile[$Address+5] = $HexValue 
    $Romfile[$Address+6] = $HexValue 
    $Romfile[$Address+7] = $HexValue 
    $Romfile[$Address+8] = $HexValue 
    $Romfile[$Address+9] = $HexValue 
    $Romfile[$Address+10] = $HexValue 
    $Romfile[$Address+11] = $HexValue 
    $Romfile[$Address+12] = $HexValue 
    $Romfile[$Address+13] = $HexValue 
    $Romfile[$Address+14] = $HexValue 
    $Romfile[$Address+15] = $HexValue 


[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)


    #Guy

$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")


    $Address = 0x10D0
    $HexValue = 0x0
    $Romfile[$Address] = $HexValue 
    $Romfile[$Address+1] = $HexValue 
    $Romfile[$Address+2] = $HexValue 
    $Romfile[$Address+3] = $HexValue 
    $Romfile[$Address+4] = $HexValue 
    $Romfile[$Address+5] = $HexValue 
    $Romfile[$Address+6] = $HexValue 
    $Romfile[$Address+7] = $HexValue 
    $Romfile[$Address+8] = $HexValue 
    $Romfile[$Address+9] = $HexValue 
    $Romfile[$Address+10] = $HexValue 
    $Romfile[$Address+11] = $HexValue 
    $Romfile[$Address+12] = $HexValue 
    $Romfile[$Address+13] = $HexValue 
    $Romfile[$Address+14] = $HexValue 
    $Romfile[$Address+15] = $HexValue 


[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)


    #Minwu

$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")


    $Address = 0x1150
    $HexValue = 0x0
    $Romfile[$Address] = $HexValue 
    $Romfile[$Address+1] = $HexValue 
    $Romfile[$Address+2] = $HexValue 
    $Romfile[$Address+3] = $HexValue 
    $Romfile[$Address+4] = $HexValue 
    $Romfile[$Address+5] = $HexValue 
    $Romfile[$Address+6] = $HexValue 
    $Romfile[$Address+7] = $HexValue 
    $Romfile[$Address+8] = $HexValue 
    $Romfile[$Address+9] = $HexValue 
    $Romfile[$Address+10] = $HexValue 
    $Romfile[$Address+11] = $HexValue 
    $Romfile[$Address+12] = $HexValue 
    $Romfile[$Address+13] = $HexValue 
    $Romfile[$Address+14] = $HexValue 
    $Romfile[$Address+15] = $HexValue 


[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)



    #Josef

$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")


    $Address = 0x11D0
    $HexValue = 0x0
    $Romfile[$Address] = $HexValue 
    $Romfile[$Address+1] = $HexValue 
    $Romfile[$Address+2] = $HexValue 
    $Romfile[$Address+3] = $HexValue 
    $Romfile[$Address+4] = $HexValue 
    $Romfile[$Address+5] = $HexValue 
    $Romfile[$Address+6] = $HexValue 
    $Romfile[$Address+7] = $HexValue 
    $Romfile[$Address+8] = $HexValue 
    $Romfile[$Address+9] = $HexValue 
    $Romfile[$Address+10] = $HexValue 
    $Romfile[$Address+11] = $HexValue 
    $Romfile[$Address+12] = $HexValue 
    $Romfile[$Address+13] = $HexValue 
    $Romfile[$Address+14] = $HexValue 
    $Romfile[$Address+15] = $HexValue 


[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)



    #Gordon

$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")


    $Address = 0x1250
    $HexValue = 0x0
    $Romfile[$Address] = $HexValue 
    $Romfile[$Address+1] = $HexValue 
    $Romfile[$Address+2] = $HexValue 
    $Romfile[$Address+3] = $HexValue 
    $Romfile[$Address+4] = $HexValue 
    $Romfile[$Address+5] = $HexValue 
    $Romfile[$Address+6] = $HexValue 
    $Romfile[$Address+7] = $HexValue 
    $Romfile[$Address+8] = $HexValue 
    $Romfile[$Address+9] = $HexValue 
    $Romfile[$Address+10] = $HexValue 
    $Romfile[$Address+11] = $HexValue 
    $Romfile[$Address+12] = $HexValue 
    $Romfile[$Address+13] = $HexValue 
    $Romfile[$Address+14] = $HexValue 
    $Romfile[$Address+15] = $HexValue 


[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)


    #Layla

$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")


    $Address = 0x12D0
    $HexValue = 0x0
    $Romfile[$Address] = $HexValue 
    $Romfile[$Address+1] = $HexValue 
    $Romfile[$Address+2] = $HexValue 
    $Romfile[$Address+3] = $HexValue 
    $Romfile[$Address+4] = $HexValue 
    $Romfile[$Address+5] = $HexValue 
    $Romfile[$Address+6] = $HexValue 
    $Romfile[$Address+7] = $HexValue 
    $Romfile[$Address+8] = $HexValue 
    $Romfile[$Address+9] = $HexValue 
    $Romfile[$Address+10] = $HexValue 
    $Romfile[$Address+11] = $HexValue 
    $Romfile[$Address+12] = $HexValue 
    $Romfile[$Address+13] = $HexValue 
    $Romfile[$Address+14] = $HexValue 
    $Romfile[$Address+15] = $HexValue 


[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)

    #Richard

$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")


    $Address = 0x1350
    $HexValue = 0x0
    $Romfile[$Address] = $HexValue 
    $Romfile[$Address+1] = $HexValue 
    $Romfile[$Address+2] = $HexValue 
    $Romfile[$Address+3] = $HexValue 
    $Romfile[$Address+4] = $HexValue 
    $Romfile[$Address+5] = $HexValue 
    $Romfile[$Address+6] = $HexValue 
    $Romfile[$Address+7] = $HexValue 
    $Romfile[$Address+8] = $HexValue 
    $Romfile[$Address+9] = $HexValue 
    $Romfile[$Address+10] = $HexValue 
    $Romfile[$Address+11] = $HexValue 
    $Romfile[$Address+12] = $HexValue 
    $Romfile[$Address+13] = $HexValue 
    $Romfile[$Address+14] = $HexValue 
    $Romfile[$Address+15] = $HexValue 


[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)


    #Leon Musk

$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")


    $Address = 0x13D0
    $HexValue = 0x0
    $Romfile[$Address] = $HexValue 
    $Romfile[$Address+1] = $HexValue 
    $Romfile[$Address+2] = $HexValue 
    $Romfile[$Address+3] = $HexValue 
    $Romfile[$Address+4] = $HexValue 
    $Romfile[$Address+5] = $HexValue 
    $Romfile[$Address+6] = $HexValue 
    $Romfile[$Address+7] = $HexValue 
    $Romfile[$Address+8] = $HexValue 
    $Romfile[$Address+9] = $HexValue 
    $Romfile[$Address+10] = $HexValue 
    $Romfile[$Address+11] = $HexValue 
    $Romfile[$Address+12] = $HexValue 
    $Romfile[$Address+13] = $HexValue 
    $Romfile[$Address+14] = $HexValue 
    $Romfile[$Address+15] = $HexValue 


[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)






        # This picks a random WeaponType and sets mastery to 4

    #Firion

$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    

    $BugWeaponAddress = $RandomWeaponAddress | Get-Random
    $WeaponAddress = [String]::Format("{0:x}", $BugWeaponAddress)
    $Address = "0xFD$WeaponAddress"
    $Romfile[$Address] = 4

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)


    #Maria

$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    

    $BugWeaponAddress = $RandomWeaponAddress | Get-Random
    $WeaponAddress = [String]::Format("{0:x}", $BugWeaponAddress)
    $Address = "0x105$WeaponAddress"
    $Romfile[$Address] = 4

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)    

    #Guy

$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    

    $BugWeaponAddress = $RandomWeaponAddress | Get-Random
    $WeaponAddress = [String]::Format("{0:x}", $BugWeaponAddress)
    $Address = "0x10D$WeaponAddress"
    $Romfile[$Address] = 4

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)

    #Minwu

$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    

    $BugWeaponAddress = $RandomWeaponAddress | Get-Random
    $WeaponAddress = [String]::Format("{0:x}", $BugWeaponAddress)
    $Address = "0x115$WeaponAddress"
    $Romfile[$Address] = 4

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)    

    #Josef

$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    

    $BugWeaponAddress = $RandomWeaponAddress | Get-Random
    $WeaponAddress = [String]::Format("{0:x}", $BugWeaponAddress)
    $Address = "0x11D$WeaponAddress"
    $Romfile[$Address] = 4

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)

    #Gordon

$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    

    $BugWeaponAddress = $RandomWeaponAddress | Get-Random
    $WeaponAddress = [String]::Format("{0:x}", $BugWeaponAddress)
    $Address = "0x125$WeaponAddress"
    $Romfile[$Address] = 4

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)    

    #Layla

$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    

    $BugWeaponAddress = $RandomWeaponAddress | Get-Random
    $WeaponAddress = [String]::Format("{0:x}", $BugWeaponAddress)
    $Address = "0x12D$WeaponAddress"
    $Romfile[$Address] = 4

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)

    #Richard

$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    

    $BugWeaponAddress = $RandomWeaponAddress | Get-Random
    $WeaponAddress = [String]::Format("{0:x}", $BugWeaponAddress)
    $Address = "0x135$WeaponAddress"
    $Romfile[$Address] = 4

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)    

    #Leon

$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    

    $BugWeaponAddress = $RandomWeaponAddress | Get-Random
    $WeaponAddress = [String]::Format("{0:x}", $BugWeaponAddress)
    $Address = "0x13D$WeaponAddress"
    $Romfile[$Address] = 4

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)


Add-Content -Path "$Currentdir\Spoilers.Txt" -Value " LW"


}

#hit 3000 lines holy crap 10/18/2021


Function KillTheParty {

        # Maria
        
$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")

    $Address = 0x1011
    $HexValue = 0x80
    $Romfile[$Address] = $HexValue 

    


[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)

        # Guy
        
$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")

    $Address = 0x1091
    $HexValue = 0x80
    $Romfile[$Address] = $HexValue 
    
    


[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)

        # Minh
        
$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")

    $Address = 0x1111
    $HexValue = 0x80
    $Romfile[$Address] = $HexValue 



[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)

        # Josef
        
$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")

    $Address = 0x1191
    $HexValue = 0x080
    $Romfile[$Address] = $HexValue 



[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)



        # Gordon
        
$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")

    $Address = 0x1211
    $HexValue = 0x80
    $Romfile[$Address] = $HexValue 



[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)

        # Layla
        
$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")

    $Address = 0x1291
    $HexValue = 0x80
    $Romfile[$Address] = $HexValue 



[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)

        # Richard
        
$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")

    $Address = 0x1311
    $HexValue = 0x80

    $Romfile[$Address] = $HexValue 



[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)

        # Leon
        
$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")

    $Address = 0x1391
    $HexValue = 0x80
    $Romfile[$Address] = $HexValue 



[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)


            # i forgot XDD, something to do with life spell

$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")

    $Address = 0x3067C
    $HexValue = 0x00
    While ($Address -le 0x30682) {
    $Romfile[$Address] = $HexValue 
    $Address++
    }

#======== this just disables life being drawn in $magicSpellslist =========#
    $MagicByteList = 192..211 -and 213..255
      
        
        # Remove life in NON-RANDO (if thats ever gonna happen) #

$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES") 
$Romfile[0x38685] = 0xE9
[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)



        
                #remove pheonix down
$Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES") 
    $Address = 0x386EE     
    $Romfile[$Address] = 0xE9


    [System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)


             #Disable life statue
 
    
    $Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES") 
    

    $NOP = 0xEA
 

    $Romfile[0x38D1A] = $NOP
    $Romfile[0x38D1A + 1] = $NOP
    $Romfile[0x38D1A + 2] = $NOP

    [System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)

    
    Add-Content -Path "$Currentdir\Spoilers.Txt" -Value " SC"

}

function CustomPlayerColor {


    
    $FirstByte =  0x05, 0x11,0x12, 0x13,0x14,0x1c,0x17,0x21,0x22,0x23,0x2a,0x2c
    $SecondByte = 0x17,0x27,0x16
    
    $MariaByte1 = 0x26
    $MariaByte2 = 0x13,0x15,0x24
    $MariaByte3 = 0x36


    #find better one


    $GuyByte1 = 0x17
    $GuyByte2 = 0x27
    $GuyByte3 = 0x30, 0x31, 0x33, 0x38, 0x3c


    $Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    


    $Address = 0x3CB    #Firion and Gordon
    $HexValue = $FirstByte | Get-Random
    $Romfile[$Address] = $HexValue 
    $HexValue2 = $SecondByte | Get-Random
    $Romfile[$Address+1] = $HexValue2

    $Address = 0x3C3    # Maria/Layla/Richard
    $HexValue = $MariaByte1 | Get-Random
    $Romfile[$Address] = $HexValue 
    $HexValue2 = $MariaByte2 | Get-Random
    $Romfile[$Address+1] = $HexValue2
    $HexValue3 = $MariaByte3 | Get-Random
    $Romfile[$Address+2] = $HexValue3

    $Address = 0x3C7    # Leon/Guy/Josef/mINWU
    $HexValue = $GuyByte1 | Get-Random
    $Romfile[$Address] = $HexValue 
    $HexValue2 = $GuyByte2 | Get-Random
    $Romfile[$Address+1] = $HexValue2
    $HexValue3 = $GuyByte3 | Get-Random
    $Romfile[$Address+2] = $HexValue3
    


    $BATTLE_PAL_1_1 = $RandomPaletteArrayDark | Get-Random
    $BATTLE_PAL_1_3 = $RandomPaletteArrayLight | Get-Random
    $BATTLE_PAL_2_1 = $RandomPaletteArrayDark | Get-Random
    $BATTLE_PAL_2_3 = $RandomPaletteArrayLight | Get-Random

    $Address  = 0x178F
    $Romfile[$Address] = $BATTLE_PAL_1_1
    $Address3 = 0x188F
    $Romfile[$Address3] = $BATTLE_PAL_1_3


    $Address  = 0x178E
    $Romfile[$Address] = $BATTLE_PAL_2_1
    $Address3 = 0x188E
    $Romfile[$Address3] = $BATTLE_PAL_2_3





    $Palette_Arrangement = $RandomPaletteMixup | Get-Random


    $Address = 0x2D26A
    $Romfile[$Address] = $Palette_Arrangement
    $Romfile[$Address+1] = $Palette_Arrangement




[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)





    

    Add-Content -Path "$Currentdir\Spoilers.Txt" -Value " RP"


}


function DoublePlayerSpeed {



        # THANKS LENOPHIS 
        
    $Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    


    $Address =  0x3D41E    # Overworld Speed
    $Address2 = 0x3D4F2   # Town Speed
    $HexValue = 0x02
    $Romfile[$Address] = $HexValue 
    $Romfile[$Address2] = $HexValue


[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)

    Add-Content -Path "$Currentdir\Spoilers.Txt" -Value " DW"


}


function MaxOutStats {




        # Firion 
        
    $Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")    

      #Adresses

    $HPC1 =  0xf98     #CurHp
    $HPC2 =  0xf99
    $HPM1 =  0xf9A     #MaxHP
    $HPM2 =  0xf9B
    $MPC1 =  0xf9C     #CurMP
    $MPC2 =  0xf9D
    $MPM1 =  0xf9E     #MaxMp
    $MPM2 =  0xf9F
    $Str  =  0xFA0
    $Agi  =  0xFA1
    $Vit  =  0xFA2
    $Int  =  0xFA3
    $Soul =  0xFA4
    $Weapon= 0xFAC 
    $Shield= 0xFAD 
    $MagPow= 0xFB5
    $WFist= 0xFD0
    $WShield= 0xFD2
    $WKnife= 0xFD4
    $WCane= 0xFD6
    $WRod= 0xFD8
    $WSword= 0xFDA
    $WAxe= 0xFDC
    $WBow= 0xFDE
    $FSpell = 0xFC0

       #Values
     
    $MaxHP1 = 0x0F
    $MaxHp2 = 0x27
    $MaxMP1 = 0xE7     #technically 2ndbyte but ff2 weird (big edian thing)
    $MaxMP2 = 0x03
    $MaxStat= 0x63
    $Masamune=0x60
    #$Masamune=0x60
    $Nine = 0x0F
    $LIFE = 0xD5
    $CURE = 0xD4

       #Process

    $Romfile[$HPC1] = $MaxHP1 
    $Romfile[$HPC2] = $MaxHP2
    $Romfile[$HPM1] = $MaxHP1 
    $Romfile[$HPM2] = $MaxHP2
    $Romfile[$MPC1] = $MaxMP1 
    $Romfile[$MPC2] = $MaxMP2
    $Romfile[$MPM1] = $MaxMP1 
    $Romfile[$MPM2] = $MaxMP2
    $Romfile[$Str] = $MaxStat
    $Romfile[$Agi] = $MaxStat
    $Romfile[$Vit] = $MaxStat
    $Romfile[$Int] = $MaxStat
    $Romfile[$Soul] = $MaxStat
    $Romfile[$Weapon] = $Masamune
    $Romfile[$Shield] = $Masamune
    $Romfile[$MagPow] = $MaxStat
    $Romfile[$WFist] = $Nine
    $Romfile[$WShield] = $Nine
    $Romfile[$WKnife] = $Nine
    $Romfile[$WCane] = $Nine
    $Romfile[$WRod] = $Nine
    $Romfile[$WSword] = $Nine
    $Romfile[$WAxe] = $Nine
    $Romfile[$WBow] = $Nine
    $Romfile[$FSpell] = $LIFE
    $Romfile[$FSpell + 1] = $CURE

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)

    Add-Content -Path "$Currentdir\Spoilers.Txt" -Value " DW"



}




function LogFile {

    
    $LogExists = Test-Path "$CurrentDir/Spoilers.Txt"

    If ($LogExists -eq $true) {
        Remove-Item -Path "$CurrentDir/Spoilers.Txt"
        }
    

    New-Item -Path $CurrentDir -Name "Spoilers.Txt" -ItemType "File" -Value "Current Flags:"









}



function Dressup {
       
    $10Random =  Get-Random -Maximum 6 -Minimum 1

    $Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")   
    
    
    $Address =  0x3E78C    # MENU MAIN
    $Address2=  0x3E787    # MENU BORDER
    $Address3=  0x1D42     # DIALOGUE MAIN
    #$Address4 = 0x1D3C     # DIALGOUE BORDER, affects houses



        #purple
    IF ($10Random -eq 1)  {

    
    $HexValue = 0x03
    $HexValue2= 0x13
    }


        #green
    IF ($10Random -eq 2)  {

    
    $HexValue = 0x09
    $HexValue2= 0x1A
    }

        #Red
    IF ($10Random -eq 3)  {

    
    $HexValue = 0x06
    $HexValue2= 0x16
    }

        #Teal
    IF ($10Random -eq 4)  {

    
    $HexValue = 0x0C
    $HexValue2= 0x1C
    }

        #Blue
    IF ($10Random -eq 5)  {

    
    $HexValue = 0x01
    $HexValue2= 0x11
    }

        #Pink
    IF ($10Random -eq 6)  {

    
    $HexValue = 0x07
    $HexValue2= 0x17
    }
    

    $Romfile[$Address] = $HexValue
    $Romfile[$Address2] = $HexValue2
    $Romfile[$Address3] = $HexValue
    #$Romfile[$Address4] = $HexValue2

[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)



}

 
function SetupAirship {



        # airship next to altair, need better JSR call
        
    $Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES") 
    
    
    


            #Pirate at altea

            $shipShown = 0x02
            $ShipX = 0x5E
            $ShipY = 0x78
            $ShipAddress = 0xAF0


            #Airship at altea
            
            $AirshipShown = 0x04
            $AirShipX = 0x5A
            $AirShipY = 0x76
            $AirShipAddress = 0xAF4



   



        $Romfile[$AirShipAddress]= $AirshipShown
        $Romfile[$AirShipAddress+1]= $AirShipX
        $Romfile[$AirShipAddress+2]= $AirShipY

        $Romfile[$ShipAddress]= $ShipShown
        $Romfile[$ShipAddress+1]= $ShipX
        $Romfile[$ShipAddress+2]= $ShipY



    
[System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)

    Add-Content -Path "$Currentdir\Spoilers.Txt" -Value " DW"







}




function RandomizeDungeonChest {


   $Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES") 

   $Address = 0xC20

   while ($address -lt 0xD0F) {
   $Hexvalue = $TreasureByteList | Get-Random
   $Romfile[$address] = $Hexvalue
   $address++
   
   }

   [System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)



}

function NoBloods {

    $Romfile  = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES") 
    
    $Address = 0x2A9E8
    $Address2= 0x2CDB7
    $Address3= 0x30278

    $romfile[$address] = 0x98
    $romfile[$address+1] = 0xB1
    $romfile[$address+2] = 0xAC
    $romfile[$address+3] = 0x44
    $romfile[$address+4] = 0x00

    $romfile[$address2] = 0x61

    $romfile[$address3] = 0x46
    $romfile[$address3+1] = 0x64
    $romfile[$address3+2] = 0x03
    $romfile[$address3+3] = 0x1E
    # no +4 on $add3
    $romfile[$address3+5] = 0x20


   [System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)

}


function NoStatDown {

    $Romfile = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")

    $Address  = 0x168EB
    $Address2 = 0x168F3
    $HexValue = 0x8A
    $Romfile[$Address] = $HexValue
    $Romfile[$Address2] = $HexValue

    [System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)

}

function MagicLVup {
    
    $Romfile = [System.IO.File]::ReadAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES")

    $Address  = 0x3ACB8
    $HexValue = 0x0A
    $Romfile[$Address] = $HexValue

    [System.IO.File]::WriteAllBytes("$CurrentDir\Final_Fantasy_2_(Tr).NES", $Romfile)
    

}

# 4000 holy crap 12/31/2021, last day of 2021
FindRom
