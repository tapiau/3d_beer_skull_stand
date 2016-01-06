$fn=180;

module torus(r1,r2)
{
    rotate_extrude(convexity = 10, $fn = 180)
    translate([r1, 0, 0])
        circle(r = r2, $fn = 90);
}

module skull()
{
    import("inc/lowpolyskulllisa_fixed.stl");
}

module skulls(r)
{
	for(n=[0:60:359])
   {
   	rotate([0,0,n])    
      translate([0,-r-20,0])
      	rotate([0,0,0])
         	scale([0.5,0.5,0.5])
            	skull();
   }
}


module base(d)
{
	r=d/2;

    difference()
    {
        union()
        {
				
				// bottom
            translate([0,0,10])
                torus(r+15,10);

            cylinder(r=r+15,h=20);
 
            translate([0,0,20])
            difference()
            {
                cylinder(r=r+15,h=5);
                translate([0,0,5])
                    torus(r+15,5);
            }
           
            translate([0,0,25])
                cylinder(r=r+10,h=10);
            
            translate([0,0,35])
                torus(r+5,5);

				skulls(r);
        }
        
			// inner
        translate([0,0,6])
        union()
        {
            cylinder(r=r,h=80);
            torus(r-3,3);
            translate([0,0,-3])
                cylinder(r=r-3,h=6);
        }
    }
}

base(70);
