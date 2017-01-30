class myFunction extends Function{
    myFunction(){
      // place the name of your function in the super constructor!
      //if the sketch is running slowly, raise the values in the PVector.
      //if the sketch is too grainy, lower the values in the PVector.
      super("*insert function name here*", new PVector(0.1,0.1));
    }
    float get(float x, float y) {
    //create your equation using processing's math controls
      return (float)(x*x+y);
  }
}