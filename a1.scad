$fn=80;

module torus(r1,r2)
{
    rotate_extrude(convexity = 10, $fn = 100)
    translate([r1, 0, 0])
        circle(r = r2, $fn = 100);
}

module skull()
{
    import("src/lowpolyskulllisa.stl");
}


module base()
{
    difference()
    {
        union()
        {
            translate([0,0,10])
                torus(60,10);

            cylinder(r=60,h=20);

            for(n=[0:60:359])
            {
                rotate([0,0,n])    
                translate([0,-63,0])
                    rotate([0,0,0])
                    scale([0.5,0.5,0.5])
                        skull();
            }

            translate([0,0,20])
            difference()
            {
                cylinder(r=60,h=5);
                translate([0,0,5])
                    torus(60,5);
            }
           
            translate([0,0,25])
                cylinder(r=55,h=10);
            
            translate([0,0,35])
                torus(50,5);
        }
        
        translate([0,0,6])
        union()
        {
            cylinder(r=45,h=80);
            torus(42,3);
            translate([0,0,-3])
                cylinder(r=42,h=6);
        }
    }
}

base();
