package com.ktxsoftware.kje.editor;

import java.awt.Color;
import java.awt.Graphics;
import java.awt.Point;
import java.awt.Rectangle;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.awt.event.MouseMotionListener;
import java.util.ArrayList;
import java.util.List;

import javax.swing.JPanel;

public class SpritesPanel extends JPanel implements MouseListener, MouseMotionListener {
	private static final long serialVersionUID = 1L;
	private static SpritesPanel instance;
	private List<Sprite> sprites = new ArrayList<Sprite>();
	private Point mouse = new Point(100, 0);
	private Sprite last = null;
	public Sprite clicked = null;
	public boolean active = false;
	
	static {
		instance = new SpritesPanel();
	}
	
	public static SpritesPanel getInstance() {
		return instance;
	}

	private SpritesPanel() {
		sprites.add(new Sprite("../Assets/Graphics/agent.png", 0, 19, 49));
		sprites.add(new Sprite("../Assets/Graphics/professor.png", 1, 20, 52));
		sprites.add(new Sprite("../Assets/Graphics/rowdy.png", 2, 25, 52));
		sprites.add(new Sprite("../Assets/Graphics/mechanic.png", 3, 21, 52));
		sprites.add(new Sprite("../Assets/Graphics/door3.png", 4, 16, 64));
		sprites.add(new Sprite("../Assets/Graphics/soldier.png", 5, 22, 41));
		sprites.add(new Sprite("../Assets/Graphics/window.png", 6, 16, 80));
		sprites.add(new Sprite("../Assets/Graphics/gate.png", 7, 16, 96));
		sprites.add(new Sprite("../Assets/Graphics/gatter.png", 8, 32, 6));
		sprites.add(new Sprite("../Assets/Graphics/computer.png", 9, 46, 60));
		sprites.add(new Sprite("../Assets/Graphics/machinegun.png", 10, 42, 41));
		sprites.add(new Sprite("../Assets/Graphics/boss.png", 11, 26, 35));
		sprites.add(new Sprite("../Assets/Graphics/car.png", 12, 100, 41));
		addMouseMotionListener(this);
		addMouseListener(this);
	}
	
	public Sprite getSprite(int index) {
		return sprites.get(index);
	}
	
	public int getSpriteCount() {
		return sprites.size();
	}

	public void paint(Graphics g) {
		Rectangle rect = getVisibleRect();
		g.setColor(Color.WHITE);
		g.fillRect(rect.x, rect.y, rect.width, rect.height);
		int x = 0;
		int y = 0;
		int ymax = 0;
		for (Sprite sprite : sprites) {
			boolean hovering = mouse.x >= x && mouse.x <= x + sprite.width && mouse.y >= y && mouse.y <= y + sprite.height;
			if (hovering) last = sprite;
			sprite.paint(g, x, y, hovering, false);
			x += sprite.width;
			if (sprite.height > ymax) ymax = sprite.height;
			if (x > 300) {
				x = 0;
				y += ymax;
				ymax = 0;
			}
		}
	}
	
	public void mouseMoved(MouseEvent e) {
		mouse = e.getPoint();
		repaint();
	}

	public void mousePressed(MouseEvent e) {
		for (Sprite sprite : sprites) sprite.selected = false;
		last.selected = true;
		clicked = last;
		active = true;
		TilesetPanel.getInstance().active = false;
		repaint();
	}

	@Override
	public void mouseDragged(MouseEvent arg0) {
		
	}

	@Override
	public void mouseClicked(MouseEvent arg0) {
			
	}

	@Override
	public void mouseEntered(MouseEvent arg0) {
		
	}

	@Override
	public void mouseExited(MouseEvent arg0) {
		
	}

	@Override
	public void mouseReleased(MouseEvent arg0) {
		
	}
}
