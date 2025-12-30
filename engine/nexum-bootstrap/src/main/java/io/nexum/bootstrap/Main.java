package io.nexum.bootstrap;

import io.nexum.Nexum;
import io.nexum.models.Size;
import io.nexum.render.Java2DRenderContext;

import static io.nexum.Nexum.LOGGER;

public class Main {
    public static void main(String[] args) {
        try {
            final Nexum nexum = Nexum.initialize(120, new Size(800, 600));
            final NexumWindow window = new NexumWindow(nexum.getScreenSize());

            nexum.setRenderContext(new Java2DRenderContext(window.getFrame()));
            nexum.setOnRender(window::repaint);
            nexum.start();
        }catch (Exception e) {
            e.printStackTrace();
            LOGGER.error("Boostrap", e.toString());
        }
    }
}