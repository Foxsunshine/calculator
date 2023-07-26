<script >

const MAX_LENGTH = 10_000_000_000_000_000_000n;

export default {
  data() {
    return {
      result: '',
      currentInput:'0',
      operator:'',
      ifShowResult:false,
      ifAvaliable:true,
      ifShowReset:false,
    }
  },
  methods: {

    reset(){
      this.ifShowReset=false
      this.result = ''
      this.currentInput='0'
      this.ifAvaliable=true
    },
    showResetMsg(){
      this.ifShowReset=true
    },

    addNumber(e){
      if(!this.ifAvaliable){
        this.showResetMsg()
      }
      let currentInput = e.target.textContent
      if(this.currentInput == '0'){
        this.currentInput = currentInput
      }else if(this.ifAvaliable){

        //入力ところ
        this.currentInput += currentInput

      }
      let length=this.currentInput.length
      if(length>=17){
          this.ifAvaliable=false
          //this.currentInput="上限超えた"
      }
      this.ifShowResult=false
    },

    operate(e){
      if(!this.ifAvaliable){
        this.showResetMsg()
      }
      if(this.operator=='')
        this.operator = e.target.textContent
       if(this.result==''){
        this.result = this.currentInput
        this.ifFirstInput=false
        this.ifShowResult=true
        this.currentInput='0'
      }else{
        this.equal()
      }
      this.operator = e.target.textContent
    },

    equal(){
      if(!this.ifAvaliable){
        this.showResetMsg()
      }
        let firstOperand=Number(this.result)
        let secondOperand=Number(this.currentInput)
        let calculationResult = 0
        if(this.operator == '+')
          calculationResult =firstOperand + secondOperand
        if(this.operator == '-')
          calculationResult =firstOperand - secondOperand
        if(this.operator == '/')
        {
          if(secondOperand == '0'){
            this.ifAvaliable = false
          }else{
            calculationResult =firstOperand / secondOperand
          }
        }
        if(this.operator == 'x'){
          calculationResult =firstOperand * secondOperand
        }
        if(!this.ifAvaliable )
          this.result=calculationResult.toString()

        if(calculationResult>=MAX_LENGTH){
          this.ifAvaliable = false
          //console.log("上限超えた!!!")
          //this.result="上限超えた"
        }

        this.ifShowResult=true
        this.currentInput='0'
    },
    del(){
      if(!this.ifAvaliable){
        this.showResetMsg()
      }
      if(this.currentInput.length==1){
        this.currentInput='0'
      }else{
        this.currentInput=this.currentInput.substring(0,this.currentInput.length-1)}
    }
  }
}

</script>

<template>
  <div class="container">
    <div class="header">
      <h4 class="logo">calc</h4>
      <div class="theme-container">
        <h5 class="theme">THEME</h5>
        <button class="theme-button">change</button>
      </div>
    </div>
    <div class="result-container">
      <h3 v-if="ifShowResult && ifAvaliable" id="result" class="result">{{result}}</h3> 
      <h3 v-else-if="!ifShowResult && ifAvaliable" id="result" class="result">{{currentInput}}</h3>
      <h3 v-else id="result" class="result">有効数字ではない</h3> 
      <h6 v-if="ifShowReset">リセットしてください</h6>
    </div>
    <div class="operater-container">
      <div class="row">
        <p @click="addNumber" class="mb-3">7</p>
        <p @click="addNumber" class="mb-3">8</p>
        <p @click="addNumber" class="mb-3">9</p>
        <p @click="del" class="mb-3 del-button">DEL</p>
      </div>
      <div class="row">
        <p @click="addNumber" class="mb-3">4</p>
        <p @click="addNumber" class="mb-3">5</p>
        <p @click="addNumber" class="mb-3">6</p>
        <p @click="operate" class="mb-3">+</p>
      </div>
      <div class="row">
        <p @click="addNumber" class="mb-3">1</p>
        <p @click="addNumber" class="mb-3">2</p>
        <p @click="addNumber" class="mb-3">3</p>
        <p @click="operate" class="mb-3">-</p>
      </div>
      <div class="row">
        <p class="mb-3">.</p>
        <p @click="addNumber" class="mb-3">0</p>
        <p @click="operate" class="mb-3">/</p>
        <p @click="operate" class="mb-3">x</p>
      </div>
      <div class="row">
        <button @click="reset" class="mb-4 reset-button">RESET</button>
        <p @click="equal" class="mb-4 equal-button">=</p>
      </div>
    </div>
  </div>
</template>

<style scoped>
.container{
  display:flex;
  flex-direction: column;
  width:350px;
  margin: 0 auto;
}
.header{
  display:flex;
  justify-content: space-between;
}
.theme-container{
  display:flex;
}
.row{
  display: flex;
  justify-content: space-between;
}
.mb-3{
  margin: 10px;
  background-color: gray;
  width: 40px;
  height: 25px;
  text-align: center;
  border-radius: 20px;
}
.mb-4{
  width: 160px;
  height: 25px;
  text-align: center;
  border-radius: 20px;
  color: aliceblue;
}
.del-button{
  background-color: aqua;
  color: aliceblue;
}
.reset-button{
  background-color: aqua;
}
.equal-button{
  background-color: red;
}
.result-container{
  text-align: right;
}

</style>