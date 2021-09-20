

Add-Type -assembly System.Windows.Forms


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



$SpellByteList = 153..191





$MagicByteList = 192..231

$RandomBaseHp = 32..80
$RandomBaseStat = 5..15
$RandomPlayerSprite = 0..8



#Rest is BS pretty sure

# Armor Bytes     70 - 98


function FindRom 
{

    #this thing has an eternal hatred for spaces
    $CheckRom = Test-Path -Path "$CurrentDir\Final_Fantasy_2_(Tr).NES"

    
    if ($CheckRom -eq $true) {
    write "rom found"
    Main
    } 
    
    else {
    write "Rom does not exist! `nPlace `"Final_Fantasy_2_(Tr).NES`" `nin this directory and try again."
    pause
    Write-Output "====================="
    findrom
    }
}






function main {


    $main_Window = New-object System.Windows.Forms.Form
    $main_Window.Size = "300,300"
    $main_Window.Text = "Main"


    $Randomize_Shops_Button = New-Object System.Windows.Forms.Button
    $Randomize_Shops_Button.Size = "75,50"
    $Randomize_Shops_Button.Location = "200,180"
    $Randomize_Shops_Button.Text = "Randomize `nShops"
    $Randomize_Shops_Button.Add_Click({RandomizeShops})




    $Randomize_Shops_Complete = New-Object System.windows.forms.Label
    $Randomize_Shops_Complete.Size = "75,24"
    $Randomize_Shops_Complete.Location = "202,235"
    $Randomize_Shops_Complete.Text = "Randomized!"

    $Tiered_Shops_Button = New-Object System.Windows.Forms.Button
    $Tiered_Shops_Button.Size = "75,50"
    $Tiered_Shops_Button.Location = "120,180"
    $Tiered_Shops_Button.Text = "Tiered `nShops"
    $Tiered_Shops_Button.Add_Click({TieredShops})

    $Tiered_Shops_Complete = New-Object System.windows.forms.Label
    $Tiered_Shops_Complete.Size = "55,24"
    $Tiered_Shops_Complete.Location = "135,235"
    $Tiered_Shops_Complete.Text = "Tiered!"


    $Randomize_Dominant_Hand = New-Object System.Windows.Forms.Button
    $Randomize_Dominant_Hand.Size = "75,50"
    $Randomize_Dominant_Hand.Location = "120,100"
    $Randomize_Dominant_Hand.Text = "Randomize `Offhand"
    $Randomize_Dominant_Hand.Add_Click({RandomizeHands})

    $Randomize_Dominant_Hand_Complete = New-Object System.windows.forms.Label
    $Randomize_Dominant_Hand_Complete.Size = "75,24"
    $Randomize_Dominant_Hand_Complete.Location = "122,155"
    $Randomize_Dominant_Hand_Complete.Text = "Randomized!"



    $Randomize_Player_Sprite = New-Object System.Windows.Forms.Button
    $Randomize_Player_Sprite.Size = "75,50"
    $Randomize_Player_Sprite.Location = "40,180"
    $Randomize_Player_Sprite.Text = "Randomize `nCharacters"
    $Randomize_Player_Sprite.Add_Click({RandomizeSprites})

    $Randomize_Player_Sprite_Complete = New-Object System.windows.forms.Label
    $Randomize_Player_Sprite_Complete.Size = "75,24"
    $Randomize_Player_Sprite_Complete.Location = "42,235"
    $Randomize_Player_Sprite_Complete.Text = "Randomized!"

    $Randomize_Base_Stats = New-Object System.Windows.Forms.Button
    $Randomize_Base_Stats.Size = "75,50"
    $Randomize_Base_Stats.Location = "200,100"
    $Randomize_Base_Stats.Text = "Randomize `nBase Stats"
    $Randomize_Base_Stats.Add_Click({RandomizeBaseStats})

    $Randomize_Base_Stats_Complete = New-Object System.windows.forms.Label
    $Randomize_Base_Stats_Complete.Size = "75,24"
    $Randomize_Base_Stats_Complete.Location = "200,158"
    $Randomize_Base_Stats_Complete.Text = "Randomized!"



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



    $Character_Select_Button = New-Object System.Windows.Forms.Button
    $Character_Select_Button.Size = "75,50"
    $Character_Select_Button.Location = "200,20"
    $Character_Select_Button.Text = "Character `nSelect"
    $Character_Select_Button.Add_Click({$Character_Select_Menu.ShowDialog()})

    $Character_Select_Complete = New-Object System.windows.forms.Label
    $Character_Select_Complete.Size = "100,24"
    $Character_Select_Complete.Location = "200,78"
    $Character_Select_Complete.Text = "Party Chosen!"



    #Kimochiwa

    $main_Window.controls.Add($Randomize_Shops_Button)
    $main_Window.controls.Add($Randomize_Dominant_Hand)
    $main_Window.controls.Add($Randomize_Player_Sprite)
    $main_Window.controls.Add($Randomize_Base_Stats)
    $main_Window.Controls.Add($Character_Select_Button)
    $main_Window.Controls.Add($Tiered_Shops_Button)


    $Character_Select_Menu.Controls.Add($Player_Label)
    $Character_Select_Menu.Controls.Add($Player1_Textbox)
    $Character_Select_Menu.Controls.Add($Player2_Textbox)
    $Character_Select_Menu.Controls.Add($Player3_Textbox)
    $Character_Select_Menu.Controls.Add($Character_Import_Button)
    $Character_Select_Menu.Controls.Add($Player_Tips)


    #asdassa
    $Main_window.ShowDialog()









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



}




Function RandomizeShops {

     


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




    $Main_window.Controls.Add($Randomize_Dominant_Hand_Complete)




}




function RandomizeSprites {


    $FirionSprite = $RandomPlayerSprite | Get-Random


    $MariaSprite = $RandomPlayerSprite | Get-Random
    While ($MariaSprite -eq $FirionSprite) {$MariaSprite = $RandomPlayerSprite | Get-Random}

    $GuySprite = $RandomPlayerSprite | Get-Random
    While ($GuySprite -eq $FirionSprite) {
            While ($GuySprite = $MariaSprite) {
                $GuySprite = $RandomPlayerSprite | Get-Random
            }
        }


    $MinwuSprite = $RandomPlayerSprite | Get-Random
    While ($MinwuSprite -eq $FirionSprite) {
        While ($MinwuSprite -eq $MariaSprite) {
            While ($MinwuSprite -eq $GuySprite) {
            $MinwuSprite = $RandomPlayerSprite | Get-Random        
            }        
        }
    }

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

main