package io.nexum.render;


import io.nexum.Nexum;
import io.nexum.channel.Channel;
import io.nexum.channel.PacketManager;
import io.nexum.events.KeyboardInputEvent;
import io.nexum.events.PointerClickEvent;
import io.nexum.events.PointerMoveEvent;
import io.nexum.events.PointerScrollEvent;
import io.nexum.models.Offset;
import io.nexum.models.Size;
import org.jetbrains.annotations.NotNull;

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.awt.image.BufferedImage;

public class Java2DWindow extends JFrame {
    private final BufferedImage frame;
    private final RenderPanel panel;

    public Java2DWindow(@NotNull Size screenSize) {
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

    public void prepare(@NotNull Nexum nexum) {
        nexum.setRenderContext(new Java2DRenderContext(this.getFrame()));
        nexum.setOnRender(this::repaint);
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
            this.setFocusable(true);

            this.addKeyListener(new KeyListener() {
                private void onKey(KeyEvent event, boolean released) {
                    if(!canEmitEvent()) return;
                    Nexum.getInstance().emitEvent(new KeyboardInputEvent(event.getKeyCode(), released));
                }

                @Override
                public void keyPressed(KeyEvent event) {
                    this.onKey(event, false);
                }

                @Override
                public void keyReleased(KeyEvent event) {
                    this.onKey(event, true);
                }

                @Override
                public void keyTyped(KeyEvent e) {

                }
            });

            this.addMouseListener(new MouseAdapter() {
                private void onMouse(MouseEvent e, boolean released) {
                    if(!canEmitEvent()) return;

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
                    if(!canEmitEvent()) return;

                    Nexum.getInstance().emitEvent(new PointerMoveEvent(
                            new Offset(e.getX(), e.getY())
                    ));
                }

                @Override
                public void mouseDragged(MouseEvent e) {

                }
            });

            this.addMouseWheelListener(e -> {
                if(!canEmitEvent()) return;

                Nexum.getInstance().emitEvent(new PointerScrollEvent(
                        new Offset(e.getX(), e.getY()),
                        e.getWheelRotation(),
                        e.getScrollAmount()
                ));
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


    private static boolean canEmitEvent() {
        return Nexum.isInitialized() && Channel.isInitialized() && PacketManager.isInitialized();
    }
}
