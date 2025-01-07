import { PrismaClient } from "@prisma/client";
import bcrypt from "bcrypt";

const prisma = new PrismaClient();
const hashPassword = async (password: string) => await bcrypt.hash(password, 8);

async function main() {
  await prisma.user.createMany({
    data: [
      {
        idUser: 1,
        email: "admin@mail.com",
        alias: "admin",
        password: await hashPassword("admin"),
      },
      {
        idUser: 2,
        email: "dev@mail.com",
        alias: "dev",
        password: await hashPassword("dev"),
      },
    ],
  });
}

main()
  .then(() => prisma.$disconnect)
  .catch((e) => {
    console.log(e);
    prisma.$disconnect();
  });
