extends KinematicBody2D

export var velocidade = 100
 
const gravidade = 50

const pulo = -80
const pulo_px = 4

var movimentar = Vector2()
var movimento = Vector2(0, 1)

var controle = {
	'cima': false,
	'baixo': false,
	'esquerda': false,
	'direita': false,
	'pular': false
}

func _physics_process(delta):
	controle_loop()
	movimento_loop(delta)
	
func controle_loop():
	self.controle['cima'] = Input.is_action_pressed("ui_up")
	self.controle['baixo'] = Input.is_action_pressed("ui_down")
	self.controle['esquerda'] = Input.is_action_pressed("ui_left")
	self.controle['direita'] = Input.is_action_pressed("ui_right")
	self.controle['pular'] = Input.is_action_just_pressed("ui_accept")

func movimento_loop(delta):
	atualizar_direcao()
	pular(delta)
	atualizar_animacao()
	
	movimentar = movimento * velocidade
	
	if !is_on_floor():
		movimentar.y += gravidade
	
	movimentar = move_and_slide(movimentar, Vector2(0, -1))


func pular(delta):
	if is_on_floor() and self.controle['pular']:
		movimento.y = lerp(movimento.y, pulo, delta * pulo_px)
	else:
		movimento.y = lerp(movimento.y, 1, delta * pulo_px)

func atualizar_animacao():
	if is_on_floor():
		if movimento.x != 0:
			$Sprite.play('correr')
			if movimento.x > 0:
				$Sprite.flip_h = false
			else:
				$Sprite.flip_h = true
		else:
			$Sprite.play('padrao')
	else:
		if movimento.y != 0:
			if movimento.y > 0:
				$Sprite.play('cair')
				if movimento.x > 0:
					$Sprite.flip_h = false
				else:
					$Sprite.flip_h = true
			else:
				$Sprite.play('pular')

	
func atualizar_direcao():
	movimento.x = -int(self.controle['esquerda']) + int(self.controle['direita'])

func die():
	get_tree().change_scene("res://lose.tscn")

func win():
	get_tree().change_scene("res://win.tscn")
