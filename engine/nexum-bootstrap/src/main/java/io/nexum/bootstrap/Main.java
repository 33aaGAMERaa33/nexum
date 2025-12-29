package io.nexum.bootstrap;

import io.nexum.Nexum;
import io.nexum.models.Size;
import static io.nexum.Nexum.LOGGER;

public class Main {
    public static void main(String[] args) {
        try {
            final Nexum nexum = Nexum.initialize(120, new Size(800, 600));
            nexum.start();

            final NexumWindow window = new NexumWindow(nexum.getScreenSize());
            nexum.setRenderer(window::setImage);
        }catch (Exception e) {
            e.printStackTrace();
            LOGGER.error("Boostrap", e.toString());
        }
    }
}