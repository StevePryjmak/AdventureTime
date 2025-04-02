# **The Death Star Plans: A Rebel Quest**

**Developed by:**

- Binh Vuong Le Duc
- Andrii-Stepan Pryimak

**Instructor:** Marcin Szlenk

**Course:** PARP

---

## **A Long Time Ago, in a Galaxy Far, Far Away...**

The Rebel Alliance has just won a small but critical victory: **Aurelia**, a central Imperial military base, is now in their hands. But before the Empire fled, they scattered pieces of a critical **Access Code** across distant planets in the star system. This code is the only way to unlock the vault on Aurelia, containing secret plans to destroy the Empire’s ultimate weapon—the **Death Star**.

As a Rebel operative, it’s your mission to gather these code fragments and outsmart the Empire before they realize what’s happening. But first, you’ll need to repair the **Millennium Falcon**, locate the fragments, and navigate treacherous worlds filled with harsh planetary environments.

---

## **Gameplay Overview**

### **Objective**

1. **Repair the Millennium Falcon**  
   Start on Aurelia, where the Falcon is in pieces. Find the essential parts scattered on this base planet to make the ship spaceworthy.

2. **Retrieve the Rebel Access Code**  
   Hidden across multiple planets are fragments of the Rebel Access Code. Explore each unique world, overcome its challenges, and locate the fragments you need to unlock the Death Star plans.

3. **Unlock the Imperial Database and Save the Galaxy**  
   Return to Aurelia once all pieces are found, use the Decoded Access Code, and open the vault to retrieve the plans that could change the fate of the galaxy.

---

## **Items and Locations**

| **Item Name**                 | **Description**                                                               |
| ----------------------------- | ----------------------------------------------------------------------------- |
| **Rebel Access Code Decoder** | Incomplete disk found on Aurelia; needs **three data fragments** to activate. |
| **Data Fragments**            | Vital parts of the Access Code, scattered across various planets.             |
| **Millennium Falcon**         | Legendary ship that enables interplanetary travel once repaired.              |
| **Ship Parts**                | Necessary to fix the Falcon, found around Aurelia.                            |
| **Old Imperial Access Key**   | Opens old storage doors and locked passages on different planets.             |

---

## **The Star System**

Prepare to navigate seven unique planets, each with its own environment, obstacles, and Rebel secrets. The exact locations of the data fragments are unknown, so each world is an adventure in discovery.

### **Planets of Interest**

1. **Aurelia** – The Rebel Base:  
   Recently liberated from the Empire, Aurelia is your starting point. Here lies the broken **Millennium Falcon**, awaiting repairs.

2. **Tempestara** – The Storm Planet:  
   Fierce storms and unpredictable weather patterns shroud this planet. Empire forces often use the chaos of the storms for cover.

3. **Verdantis** – The Forest Planet:  
   Verdantis is a lush, jungle-filled planet, alive with both dense vegetation and hidden Rebel caches. Known for its vast wilderness, it’s a place of mystery.

4. **Ignisia** – The Volcanic World:  
   With landscapes of molten lava and active volcanoes, Ignisia presents both beauty and danger. Imperial forces rarely venture into its fiery terrain.

5. **Dunestria** – The Desert Planet:  
   A barren desert world, scattered with old ruins and lost Rebel outposts. A place to explore but full of Imperial secrets.

6. **Desolara** – The Wasteland:  
   This desolate planet is a wasteland of forgotten Imperial technology. It serves as a link to other planets but has its own hidden dangers.

7. **Glaciera** – The Frozen Planet:  
   Glaciera’s icy landscapes and frozen plains hide Rebel caches and ancient artifacts buried under the snow. Its harsh climate keeps it largely uninhabited.

---

### **Travel System: Hyperspace Lanes**

The Empire’s **Hyperspace Lane Network** limits Rebel movement, forcing navigation along four fixed directions—North, South, East, and West. These lanes divide the star system into quadrants, which keeps navigation straightforward while leaving room for strategic travel decisions.

---

### Hints

<details>
   <summary>Hint 1: Star system navigation map</summary>

```
[Tempestara]              [Dunestria]
      O         < w --- e >      O                                   n = North
      |                          |                       w = West        O       e = East
      ^                          ^                                   s = South
      n                          n
      |                          |
      s                          s
      v                          v

[Desolara]                 [Aurelia]                 [Verdantis]
      O        < w --- e >       O        < w --- e >       O

                                              ^                          ^
                                              n                          n
                                              |                          |
                                              s                          s
                                              v                          v

                                              O        < w --- e >       O
                                       [Glaciera]                 [Ignisia]
```

</details>

<details>
   <summary>Hint 2: The fragments of the Rebel Access Code are hidden in</summary>

- Tempestara: **Tempest Fragment**
- Verdantis: **Verdant Fragment**
- Ignisia: **Pyro Fragment**
</details>

<details>
   <summary>Hint 3: Find and use the Old Imperial Access Key to unlock hidden doors on Tempestara and Ignisia</summary>

- You can find them in: **Dunestria** and **Desolara**.
</details>

<details>
   <summary>Hint 4: There is a winning guide in the Walkthrough file</summary>

- [Walkthrough](./how-to-win.txt)
</details>


### **How to Compile and Play**

1. **Install GST (GNU Smalltalk)**  
   In newer versions of Linux, GST is not directly supported, and the usual `sudo apt install gst` command may not work. To install GST, follow these steps:  
   - Download the `gst` tarball (`.tar.gz`) file from the official GNU Smalltalk repository.  
   - Extract the file using the command:  
     ```bash
     tar -xvzf smalltalk-<version>.tar.gz
     ```  
   - Navigate to the extracted folder:  
     ```bash
     cd smalltalk-<version>
     ```  
   - Configure, build, and install GST:  
     ```bash
     ./configure
     make
     sudo make install
     ```  
   - Ensure GST is installed correctly by running:  
      ```bash
      gst --version
      ```
2. **Run game using one of 2 ways**
   - Run directly
      ```bash
      gst item.st door.st planet.st aurelia.st verdantis.st dunestria.st tempestara.st desolara.st ignisia.st glaciera.st player.st gameMap.st adventure.st
      ```
   - Use prepered makefile instead
      ```bash
      make run
      ```
   Enjoy the game.

