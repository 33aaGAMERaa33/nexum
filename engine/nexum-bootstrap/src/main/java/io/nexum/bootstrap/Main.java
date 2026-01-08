package io.nexum.bootstrap;

import io.nexum.Nexum;
import io.nexum.models.Size;
import io.nexum.render.Java2DWindow;

import static io.nexum.Nexum.LOGGER;

public class Main {
    public static void main(String[] args) {
        try {
            final Nexum nexum = Nexum.initialize(120, new Size(800, 600));
            final Java2DWindow window = new Java2DWindow(nexum.getScreenSize());

            window.prepare(nexum);
            nexum.start("../../");
        }catch (Exception e) {
            e.printStackTrace();
            LOGGER.error("Boostrap", e.toString());
        }
    }
}