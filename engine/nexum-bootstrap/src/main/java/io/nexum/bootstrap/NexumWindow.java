package io.nexum.bootstrap;


import io.nexum.Nexum;
import io.nexum.channel.PacketManager;
import io.nexum.events.PointerClickEvent;
import io.nexum.events.PointerMoveEvent;
import io.nexum.models.Offset;
import io.nexum.models.Size;
import org.jetbrains.annotations.NotNull;

import javax.swing.*;
import java.awt.*;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.awt.event.MouseMotionListener;
import java.awt.image.BufferedImage;

public class NexumWindow extends JFrame {
    private final BufferedImage frame;
    private final RenderPanel panel;

    public NexumWindow(@NotNull Size screenSize) {
        this.panel = new RenderPanel();

        this.frame = new BufferedImage(
                screenSize.getWidth(), screenSize.getHeight(),
                BufferedImage.TYPE_INT_ARGB_PRE
        );

        this.setTitle("Nexum");
        this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        this.setResizable(false);

        this.panel.setPreferredSize(new Dimension(
                screenSize.getWidth(),
                screenSize.getHeight())
        );

        this.add(panel);

        this.pack();
        this.setLocationRelativeTo(null);
        this.setVisible(true);
    }

    @Override
    public void repaint() {
        super.repaint();
        this.panel.repaint();
    }

    public BufferedImage getFrame() {
        return frame;
    }

    private class RenderPanel extends JPanel {
        public RenderPanel() {
            this.addMouseListener(new MouseAdapter() {
                private void onMouse(MouseEvent e, boolean released) {
                    if(!PacketManager.isInitialized()) return;

                    final PointerClickEvent clickEvent = new PointerClickEvent(
                            new Offset(e.getX(), e.getY()), released
                    );

                    Nexum.getInstance().emitEvent(clickEvent);
                }

                @Override
                public void mousePressed(MouseEvent e) {
                    this.onMouse(e, false);
                }

                @Override
                public void mouseReleased(MouseEvent e) {
                    this.onMouse(e, true);
                }
            });

            this.addMouseMotionListener(new MouseMotionListener() {
                @Override
                public void mouseMoved(MouseEvent e) {
                    if(!PacketManager.isInitialized()) return;

                    Nexum.getInstance().emitEvent(new PointerMoveEvent(
                            new Offset(e.getX(), e.getY())
                    ));
                }

                @Override
                public void mouseDragged(MouseEvent e) {

                }
            });
        }

        @Override
        protected void paintComponent(Graphics g) {
            super.paintComponent(g);

            if(frame != null) {

                g.drawImage(
                        frame,
                        0,
                        0,
                        getWidth(),
                        getHeight(),
                        null
                );
            }
        }
    }

}
