
Dissolve Form Drawing
# First create components and then the form 
$MyPanel = Create-Panel -BgColor "Black" -SizeX 100 -SizeY 100 -LocX 100 -LocY 100
$MyForm = Create-Form -Title "Heading" -SizeX 300 -SizeY 300 -Posititon "center" -Component {$Mypanel}
#Connect-Component -Form $MyForm -Component {$MyPanel}
Show-Form $MyForm

Dissolve
Add-Form
Add-Drawing
Create-Form
Create-Panel
Create-Box
Create-Square
Create-Reactangle
Create-Triangle
Create-Circle
Create-Button
Create-Input
Create-Label
Create-Heading
Connect-Components
Show-Form


# Load Windows Forms assembly
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing


Function Set-Color($color) {
	[System.Drawing.Color]::$color  # Change color if needed
}

Function Set-Size {
	param(
		[Int]$X,
		[Int]$Y
	)
	 
	#[System.Drawing.Size]::new($X, $Y)
	New-Object System.Drawing.Size($X, $Y)
}

Function Set-Point {
	param(
		[Int]$X,
		[Int]$Y
	)100
	#[System.Drawing.Point]::new($X, $Y)
	New-Object System.Drawing.Point($X, $Y) 
}


Function Start-Position {
	if ($args[0] -eq "center") {
		echo "hello"
		[System.Windows.Form.FormStartPosition]::CenterScreen
	}
}

# Create-Form -Text "Simple Square" # otherwiss the default text will be something else

# Create a new Windows Form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Simple Square"
$form.Size = Set-Size 300 300
$form.StartPosition = Start-Position "center"
#$form.StartPosition = [System.Windows.Form.FormStartPosition]::CenterScreen

# Create a panel to represent the square
$square = New-Object System.Windows.Forms.Panel
$square.BackColor = Set-Color "Black"
$square.Size = Set-Size 100 100
$square.Location = Set-Point 100 100

# Add the square to the form
$form.Controls.Add($square)

# Show the form
$form.ShowDialog()

