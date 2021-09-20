

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
$ArmorByteList = 112..152
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

    $Randomize_Dominant_Hand = New-Object System.Windows.Forms.Button
    $Randomize_Dominant_Hand.Size = "75,50"
    $Randomize_Dominant_Hand.Location = "120,180"
    $Randomize_Dominant_Hand.Text = "Randomize `Offhand"
    $Randomize_Dominant_Hand.Add_Click({RandomizeHands})

    $Randomize_Dominant_Hand_Complete = New-Object System.windows.forms.Label
    $Randomize_Dominant_Hand_Complete.Size = "75,24"
    $Randomize_Dominant_Hand_Complete.Location = "122,235"
    $Randomize_Dominant_Hand_Complete.Text = "Randomized!"



    $Randomize_Player_Sprite = New-Object System.Windows.Forms.Button
    $Randomize_Player_Sprite.Size = "75,50"
    $Randomize_Player_Sprite.Location = "40,180"
    $Randomize_Player_Sprite.Text = "Randomize `nPlayer"
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



    #Kimochiwa

    $main_Window.controls.Add($Randomize_Shops_Button)
    $main_Window.controls.Add($Randomize_Dominant_Hand)
    $main_Window.controls.Add($Randomize_Player_Sprite)
    $main_Window.controls.Add($Randomize_Base_Stats)



    #asdassa
    $Main_window.ShowDialog()









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




main