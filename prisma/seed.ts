import { PrismaClient } from "@prisma/client";
import bcrypt from "bcrypt";

const prisma = new PrismaClient();
const hashPassword = async (password: string) => await bcrypt.hash(password, 8);

async function main() {
  await prisma.permissionAction.createMany({
    data: [
      {
        permissionDo: "manage",
      },
      {
        permissionDo: "create",
      },
      {
        permissionDo: "read",
      },
      {
        permissionDo: "update",
      },
      {
        permissionDo: "delete",
      },
    ],
  });
  await prisma.permissionSubject.createMany({
    data: [
      {
        permissionSubject: "all",
      },
      {
        permissionSubject: "dashboard",
      },
      {
        permissionSubject: "perfil",
      },
      {
        permissionSubject: "analitycs",
      },
    ],
  });
  await prisma.role.createMany({
    data: [
      {
        role: "Admin",
      },
      {
        role: "Talent",
      },
    ],
  });
  await prisma.rolePermission.createMany({
    data: [
      {
        idRolPermission: 1,
        role: "Admin",
        permissionDo: "manage",
        permissionSubject: "all",
      },
      {
        idRolPermission: 2,
        role: "Talent",
        permissionDo: "read",
        permissionSubject: "dashboard",
      },
      {
        idRolPermission: 3,
        role: "Talent",
        permissionDo: "read",
        permissionSubject: "perfil",
      },
      {
        idRolPermission: 4,
        role: "Talent",
        permissionDo: "create",
        permissionSubject: "perfil",
      },
      {
        idRolPermission: 5,
        role: "Talent",
        permissionDo: "update",
        permissionSubject: "perfil",
      },
    ],
  });

  await prisma.user.createMany({
    data: [
      {
        idUser: 1,
        role: "Admin",
        email: "admin@mail.com",
        alias: "admin@mail.com",
        password: await hashPassword("admin"),
      },
      {
        idUser: 2,
        role: "Talent",
        email: "dev@mail.com",
        alias: "dev@mail.com",
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
