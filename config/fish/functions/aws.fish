# Defined in - @ line 1
function aws --wraps='aws-vault exec cc:prod -- aws' --description 'alias aws aws-vault exec cc:prod -- aws'
  aws-vault exec cc:prod -- aws $argv;
end
