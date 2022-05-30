// Title: Retina Heatmap
// First version: 1.0 - 03/23/2021 

// Description: This macro performs a retina nuclear layer thickness heatmap
//
//------------------------------------
// Authors: Daniel E. Maidana, M.D. and Demetrios G. Vavvas, M.D., Ph.D.
// Massachusetts Eye and Ear Infirmary
// Harvard Medical School
// 243 Charles Street, Boston MA (02114)
// Unites States of America
// GitHub: https://github.com/DanielMaidana/ThicknessTool
// Web: https://imagej.net/RETINA_Analysis_Toolkit
//------------------------------------
// Note: Please review istructions before use!

// Copyright (C) <2021>  <Daniel E. Maidana, MD and Demetrios G. Vavvas, MD, PhD>

// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.
    
//-----------------------------------------------------------------------------// Physics LUT 144 = Green -> Minimum, 255 = Red -> Maximum
// Values in Pixels
setBatchMode(true);
newImage("Heatmap", "8-bit black", 5223, 8149, 1);
roiManager("Select", 0);
run("Clear", "slice");
run("Line Width...", "line=5");
run("Set Measurements...", "mean feret's redirect=None decimal=3");
TotalLines = roiManager("count");
	for (i=1; i<TotalLines; i++) {
		run("Clear Results");
		roiManager("Select", i);
		roiManager("Measure");
		Local_Thickness = getResult("Feret", 0);
		Y_Pixel_Value = 93.056422 + 0.791664*Local_Thickness + 0*(Local_Thickness-134.456)^2 + 0*(Local_Thickness-134.456)^3;
		setBackgroundColor(Y_Pixel_Value,Y_Pixel_Value,Y_Pixel_Value);
		roiManager("Select", i);
		roiManager("Set Line Width", 2);
		run("Clear", "slice");
		Local_Thickness = 0;
		Y_Pixel_Value = 0;
		setBackgroundColor(0,0,0);
		run("Clear Results");
		}
setBackgroundColor(0,0,0);
run("Select None");
run("Physics"); //THIS ONE
roiManager("Select", 0);
setBackgroundColor(0, 0, 0);
run("Clear Outside");
setBatchMode("show");