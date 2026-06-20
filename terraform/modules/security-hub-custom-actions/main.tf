resource "aws_securityhub_action_target" "investigate" {
  name        = "TITANInvestigate"
  identifier  = "TITANInvestigate"
  description = "Send selected finding to the TITAN investigation workflow."
}

resource "aws_securityhub_action_target" "escalate" {
  name        = "TITANEscalate"
  identifier  = "TITANEscalate"
  description = "Escalate selected finding for priority security review."
}

resource "aws_securityhub_action_target" "suppress" {
  name        = "TITANSuppress"
  identifier  = "TITANSuppress"
  description = "Send selected finding to the TITAN suppression review workflow."
}