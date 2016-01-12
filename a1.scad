$fn=90;

module torus(r1,r2)
{
    rotate_extrude(convexity = 10)
    translate([r1, 0, 0])
        circle(r = r2);
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
			h1=12;
            h2=23;
            d1=6;
            d2=3;
            
			// bottom
            translate([0,0,h1/2])
                torus(r+h1/2*1.5+d2,h1/2);
            cylinder(r=r+h1/2*1.5+d2,h=h1);
        
            // radial cut
            translate([0,0,h1])
            difference()
            {
                cylinder(r=r+d1*1.5,h=d1/2);
                translate([0,0,d1/2])
                    torus(r+d1*1.5,d1/2);
            }
                       
            // chimney
            cylinder(r=r+d1,h=h2);
            
            translate([0,0,h2])
            {
                torus(r+d1/2,d1/2);
            }
            
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
