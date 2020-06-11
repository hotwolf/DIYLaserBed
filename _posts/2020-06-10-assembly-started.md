---
layout: post
title:  Assembly started
---

Finally all vitamins have arrived in the mail.
As I have started the assembly of the DIYLaserBed I found a number offlaws in the design:

## Carriage

The T-Nuts have been misplaced. Tn the construction, they actually reach into the extrusions.

![Displaced T-Nut]({{ site.url }}/images/2020-06-10-displaced_tnut_in_carriage.png)

For the assembly this means that shorter M4 screws are required ttan listed in the BOM.

## Rails

I had ordered cheap rails from China.
As it turns out, the holes in the rails were not aligned as expected, therefore the holders
peek out over the edge of the column extrusions.

![Rail holders too long]({{ site.url }}/images/2020-06-10-rail_holders_too_long.png)

The rail holders have now been shortened to compensate for the offset of the holes. 

## Crank Bearing holder

The lower bearing holder of the crank does not fit right because the L-brackest are in the way.

![Crank bearing holder]({{ site.url }}/images/2020-06-10-crank_bearing_holder.png)

The inner profile of the holder had to be adjusted.

## Crank

The biggest design flaw of them all is the crank itself. It is simply too high to fit into the
laser cutter's enclosure. The stepper motor of the X-axis will crash against it.

![Crank too high]({{ site.url }}/images/2020-06-10-crank_too_high.png )

I've replaced the shaft with a M8 hex screw and designed a flat crank that fits on the screw head.

![Flat crank]({{ site.url }}/images/2020-06-10-flat_crank.png )

All of these design problems have been fixed in the repository.


