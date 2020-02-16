--[[



 ################################################
 #                                              #
 #              Script Criado Por               #
 #           FACEBOOK.COM/AIRNEWSCR             #
 #                                              #
 #                                              #
 ################################################



--]]

--------------------------------------------------------------------

local screenW,screenH = guiGetScreenSize()
local resW, resH = 1366,768
local x, y = (screenW/resW), (screenH/resH)

RGPainel = false

function AirNew_Scripter_DXRG ()

    local AirNew_Scripter_RGNumero = getElementData ( localPlayer, "AirNew_RG" ) or "Erro Desconhecido, Contate um Administrador (01)"
    local AirNew_Scripter_DataExpedicao = getElementData ( localPlayer, "AirNew_DataExpedicao" ) or "Erro Desconhecido, Contate um Administrador (02)"
    local AirNew_Scripter_NomeCompleto = getElementData ( localPlayer, "AirNew_RG_NomeCompleto" ) or "Erro Desconhecido, Contate um Administrador (03)"
    local AirNew_Scripter_DataDeNascimento = getElementData ( localPlayer, "AirNew_RG_DataDeNascimento" ) or "Erro Desconhecido, Contate um Administrador (04)"
    local AirNew_Scripter_LocalDeNascimento = getElementData ( localPlayer, "AirNew_RG_LocalDeNascimento" ) or "Erro Desconhecido, Contate um Administrador (05)"

    dxDrawRectangle(x*467, y*173, x*432, y*233, tocolor(216, 254, 206, 150), false)
    dxDrawRectangle(x*472, y*178, x*421, y*224, tocolor(22, 101, 2, 150), false)
    dxDrawRectangle(x*478, y*183, x*409, y*214, tocolor(216, 254, 206, 150), false)
    dxDrawText("Registro Geral: "..AirNew_Scripter_RGNumero, x*488, y*224, x*877, y*249, tocolor(0, 0, 0, 255), x*1.00, "default", "left", "top", false, false, false, false, false)
    dxDrawText("Data de Expedição: "..AirNew_Scripter_DataExpedicao.." Horas", x*488, y*249, x*877, y*274, tocolor(0, 0, 0, 255), x*1.00, "default", "left", "top", false, false, false, false, false)
    dxDrawText("Nome: "..AirNew_Scripter_NomeCompleto, x*488, y*274, x*877, y*299, tocolor(0, 0, 0, 255), x*1.00, "default", "left", "top", false, false, false, false, false)
    dxDrawText("Data de Nascimento: "..AirNew_Scripter_DataDeNascimento, x*488, y*299, x*877, y*324, tocolor(0, 0, 0, 255), x*1.00, "default", "left", "top", false, false, false, false, false)
    dxDrawText("Local de Nascimento: "..AirNew_Scripter_LocalDeNascimento, x*488, y*324, x*877, y*349, tocolor(0, 0, 0, 255), x*1.00, "default", "left", "top", false, false, false, false, false)
    dxDrawRectangle(x*478, y*188, x*409, y*16, tocolor(247, 68, 68, 118), false)
    dxDrawText("Válida em Todo o Território de San Andreas", x*488, y*183, x*877, y*208, tocolor(0, 0, 0, 255), x*1.00, "default", "center", "center", false, false, false, false, false)
    dxDrawRectangle(x*478, y*371, x*409, y*16, tocolor(247, 68, 68, 118), false)
    dxDrawText("Documento Fictício (Sem Valor fora do Mundo Virtual)", x*488, y*367, x*877, y*392, tocolor(0, 0, 0, 255), x*1.00, "default", "center", "center", false, false, false, false, false)
end

function AirNew_Scripter_AbrirFecharRGDX ()
if RGPainel == false then
addEventHandler ( "onClientRender", root, AirNew_Scripter_DXRG )
RGPainel = true
else
removeEventHandler ( "onClientRender", root, AirNew_Scripter_DXRG )
RGPainel = false
end
end
addCommandHandler ( "rg", AirNew_Scripter_AbrirFecharRGDX )

---------- Criar essa merda maluco

AirNewSCR01 = guiCreateEdit ( x*529, y*271, x*349, y*21, "Nome Completo", false )
guiSetVisible ( AirNewSCR01, false )
guiSetAlpha ( AirNewSCR01, 0.85 )
	
AirNewSCR02 = guiCreateEdit( x*607, y*296, x*271, y*21, "00/00/0000", false)
guiSetVisible ( AirNewSCR02, false )
guiSetAlpha ( AirNewSCR02, 0.85 )
guiEditSetMaxLength ( AirNewSCR02, 10 )
	
AirNewSCR03 = guiCreateEdit( x*607, y*321, x*271, y*21, "Cidade - Estado, Exemplo: São Paulo - SP", false)
guiSetVisible ( AirNewSCR03, false )
guiSetAlpha ( AirNewSCR03, 0.85 )
guiEditSetMaxLength ( AirNewSCR03, 40 )
	
function ConfigurarBrancos ()
	if CriandoRG == true then
		AirNewSCR_edit01 = guiGetText(AirNewSCR01)
		AirNewSCR_edit02 = guiGetText(AirNewSCR02)
		AirNewSCR_edit03 = guiGetText(AirNewSCR03)
	end
end
setTimer ( ConfigurarBrancos, 50, 0 )

AirNewSCR_edit01 = 0
AirNewSCR_edit02 = 0
AirNewSCR_edit03 = 0

CriandoRG = false
	
function CriarRG ()

    local AirNew_Scripter_RGNumero = getElementData ( localPlayer, "AirNew_RG" ) or "Erro Desconhecido, Contate um Administrador (01)"
    local AirNew_Scripter_DataExpedicao = getElementData ( localPlayer, "AirNew_DataExpedicao" ) or "Erro Desconhecido, Contate um Administrador (02)"

    dxDrawRectangle(x*467, y*173, x*432, y*233, tocolor(216, 254, 206, 150), false)
    dxDrawRectangle(x*472, y*178, x*421, y*224, tocolor(22, 101, 2, 150), false)
    dxDrawRectangle(x*478, y*183, x*409, y*214, tocolor(216, 254, 206, 150), false)
    dxDrawText("Registro Geral: "..AirNew_Scripter_RGNumero, x*488, y*224, x*877, y*249, tocolor(0, 0, 0, 255), x*1.00, "default", "left", "top", false, false, false, false, false)
    dxDrawText("Data de Expedição: "..AirNew_Scripter_DataExpedicao, x*488, y*249, x*877, y*274, tocolor(0, 0, 0, 255), x*1.00, "default", "left", "top", false, false, false, false, false)
    dxDrawText("Nome:", x*488, y*274, x*877, y*299, tocolor(0, 0, 0, 255), x*1.00, "default", "left", "top", false, false, false, false, false)
    dxDrawText("Data de Nascimento:", x*488, y*299, x*877, y*324, tocolor(0, 0, 0, 255), x*1.00, "default", "left", "top", false, false, false, false, false)
    dxDrawText("Local de Nascimento:", x*488, y*324, x*877, y*349, tocolor(0, 0, 0, 255), x*1.00, "default", "left", "top", false, false, false, false, false)
    dxDrawRectangle(x*478, y*188, x*409, y*16, tocolor(247, 68, 68, 118), false)
    dxDrawText("Válida em Todo o Território de San Andreas", x*488, y*183, x*877, y*208, tocolor(0, 0, 0, 255), x*1.00, "default", "center", "center", false, false, false, false, false)
    dxDrawRectangle(x*478, y*371, x*409, y*16, tocolor(247, 68, 68, 118), false)
    dxDrawText("Documento Fictício (Sem Valor fora do Mundo Virtual)", x*488, y*367, x*877, y*392, tocolor(0, 0, 0, 255), x*1.00, "default", "center", "center", false, false, false, false, false)
    dxDrawRectangle(x*467, y*411, x*432, y*26, tocolor(216, 254, 206, 150), false)
	if cursorPosition ( x*472, y*415, x*421, y*17 ) then
    dxDrawRectangle(x*472, y*415, x*421, y*17, tocolor(255, 0, 0, 150), false)
	else
	dxDrawRectangle(x*472, y*415, x*421, y*17, tocolor(0, 0, 0, 150), false)
	end
    dxDrawText("Confirmar e Continuar", x*473, y*415, x*893, y*432, tocolor(255, 255, 255, 255), x*1.00, "default", "center", "center", false, false, false, false, false)
end

function AirNew_Scripter_AbrirFecharRGCriacao ()
if CriandoRG == false then
addEventHandler ( "onClientRender", root, CriarRG )
guiSetVisible ( AirNewSCR01, true )
guiSetVisible ( AirNewSCR02, true )
guiSetVisible ( AirNewSCR03, true )
showCursor ( true )
CriandoRG = true
else
removeEventHandler ( "onClientRender", root, CriarRG )
guiSetVisible ( AirNewSCR01, false )
guiSetVisible ( AirNewSCR02, false )
guiSetVisible ( AirNewSCR03, false )
showCursor ( false )
CriandoRG = false
end
end

function ReceberSolicitacaoCriarRG ()
  if getElementData ( localPlayer, "AirNew_SolicitarCriarRG" ) == "Sim" then
  setElementData ( localPlayer, "AirNew_SolicitarCriarRG", "Não" )
  AirNew_Scripter_AbrirFecharRGCriacao () -- Abrir
  end
end
setTimer ( ReceberSolicitacaoCriarRG, 1, 0 )

function ConfirmarContinuar (_,state)
if CriandoRG == true then
if state == "down" then
if isCursorOnElement ( x*472, y*415, x*421, y*17 ) then
if guiGetText(AirNewSCR01) == "Nome Completo" or guiGetText(AirNewSCR02) == "00/00/0000" or guiGetText(AirNewSCR03) == "Cidade - Estado, Exemplo: São Paulo - SP" then
outputChatBox ( "Verifique Os Campos Preenchidos, e Tente Novamente!" )
  return
end
setElementData ( localPlayer, "AirNew_RG_NomeCompleto", ""..AirNewSCR_edit01.."" )
setElementData ( localPlayer, "AirNew_RG_DataDeNascimento", ""..AirNewSCR_edit02.."" )
setElementData ( localPlayer, "AirNew_RG_LocalDeNascimento", ""..AirNewSCR_edit03.."" )

AirNew_Scripter_AbrirFecharRGCriacao () -- Fechar
setElementData ( localPlayer, "AirNew_PossuiRG", "Sim" )

end
end
end
end
addEventHandler ( "onClientClick", root, ConfirmarContinuar )

-- Extras

function cursorPosition(x, y, w, h)
	if (not isCursorShowing()) then
		return false
	end
	local mx, my = getCursorPosition()
	local fullx, fully = guiGetScreenSize()
	cursorx, cursory = mx*fullx, my*fully
	if cursorx > x and cursorx < x + w and cursory > y and cursory < y + h then
		return true
	else
		return false
	end
end

function isCursorOnElement( x,y,w,h )
local mx,my = getCursorPosition ()
local fullx,fully = guiGetScreenSize()
cursorx,cursory = mx*fullx,my*fully
if cursorx > x and cursorx < x + w and cursory > y and cursory < y + h then
return true
else
return false
end
end