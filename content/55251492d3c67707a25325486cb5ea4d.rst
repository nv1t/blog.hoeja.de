bullet time video #1
####################
:date: 2011-03-29 21:16
:tags: en, mathematics, numerics, photographie

Today, `Rene Krause`_ suggested making a bullet time video from borrowed
DSLRs cameras. There are several problems which have to be fixed:

-  Getting enough cameras together (24 upwards)
-  Syncronising the cameras to shoot at the exact moment
-  stitching the images into a videoclip

The first problem is kinda easy to solve: Get enough people, with enough
cameras. Syncronising the cameras is much more difficult. I'm thinking
about a self made bullet time video as a clip, which can be made by many
cameras. Syncronising would be easy, if everybody uses the same camera.
But we get: Canon, Nikon, and much more. I'm even thinking about using
not only DSLRs cameras, but normal pocket cameras as well. I'm not quite
sure how to sync them...but probably if the camera is accessible by
computer, it should be possible to shoot from a computer or over an
arduino interface, which sends the correct signal. But you have to have
an arduino foreach camera, which gets an rf signal to send the shoot
signal. And even then, you have sync problems, coz every camera needs
it's own time to shoot. Now to the final problem: stitching the images
into a videoclip. You are left with different pictures, different
viewpoints and angles onto the object. You have to determine where in
the picture it is, how it is rotated, and so on...I thought about using
keypoint technics from normal panoramic software to determine the
rotation and position of the camera. If you mark 4 dots, at the wall
behind the object it should be possible to determine the exact position
from the camera to the object. from this position you can calculate back
the rotation and how it should be fitted inside the video. i'm not quite
sure if that works, but i have to try it out anyway. With such a
software you can make your own bullet time videos with a lot of
different cameras. If you get a lot of people and let them make the
picture by themself. The software should determine their position to the
object and calculate the best use in the video. Another possibility to
sync all cameras would be: long time exposure in complete darkness and
then using a photoflash to get the picture. I'm eager to work on such a
piece of software...it would be amazing. so long.

.. _Rene Krause: http://www.lipsiart.de/
