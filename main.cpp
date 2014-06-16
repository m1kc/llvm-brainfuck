//#include <cstdio>

#include <llvm/IR/LLVMContext.h>
#include <llvm/IR/Module.h>
#include <llvm/IR/IRBuilder.h>
#include <llvm/Support/raw_ostream.h>

using namespace llvm;

static const uint64_t DATA_SIZE = 30000;
static const char *DATA_NAME = "data";
static const char *PTR_NAME = "ptr";

int main() {
  // LLVM context.
  LLVMContext &Context = getGlobalContext();
  Module MainModule("brainfuck program", Context);
  IRBuilder<> Builder(Context);

  // Some useful constants.
  Type *CellType = Type::getInt8Ty(Context);

  // Global data for a brainfuck program.
  ArrayType *DataType = ArrayType::get(CellType, DATA_SIZE);
  GlobalVariable *Data = new GlobalVariable(
      MainModule, DataType, false /* constant */,
      GlobalVariable::InternalLinkage, Constant::getNullValue(DataType),
      DATA_NAME);
  Value *DataPtr = Builder.CreateConstInBoundsGEP2_32(Data, 0, 0, PTR_NAME);
  (void) DataPtr;  // unused

  // Main function definition.
  FunctionType *MainFunctionType = FunctionType::get(
      Type::getVoidTy(Context) /* return type */,
      //std::vector<const Type *>() /* argument types */,
      false /* var args */);
  Function *MainFunction = Function::Create(MainFunctionType,
      Function::ExternalLinkage, "brainfuck_main", &MainModule);
  BasicBlock *MainBlock = BasicBlock::Create(Context, "entry", MainFunction);
  Builder.SetInsertPoint(MainBlock);

  // Finish off brainfuck_main and dump.
  Builder.CreateRetVoid();
  MainModule.print(outs(), NULL /* assembly annotation writer */);
}
