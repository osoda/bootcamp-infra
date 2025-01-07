-- CreateTable
CREATE TABLE "Account" (
    "idAccount" SERIAL NOT NULL,
    "idUser" INTEGER NOT NULL,
    "keyAuthProvider" VARCHAR(100) NOT NULL,
    "type" VARCHAR(5) NOT NULL,
    "providerAccountId" VARCHAR(120) NOT NULL,
    "refreshToken" VARCHAR(255),
    "accessToken" VARCHAR(255),
    "expiredAt" TIMESTAMP(0),
    "tokenType" VARCHAR(255),
    "scope" VARCHAR(255),
    "idToken" VARCHAR(255),
    "sessionState" VARCHAR(45),
    "dateStart" TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "dateUpd" TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Account_pkey" PRIMARY KEY ("idAccount")
);

-- CreateTable
CREATE TABLE "AuthProvider" (
    "keyAuthProvider" VARCHAR(100) NOT NULL,
    "description" VARCHAR(255),

    CONSTRAINT "AuthProvider_pkey" PRIMARY KEY ("keyAuthProvider")
);

-- CreateTable
CREATE TABLE "CareerTimeline" (
    "idCareerTimeline" SERIAL NOT NULL,
    "idPerson" INTEGER NOT NULL,
    "career" VARCHAR(45) NOT NULL,
    "description" TEXT NOT NULL,
    "company" VARCHAR(255) NOT NULL,
    "init" DATE NOT NULL,
    "end" DATE NOT NULL,
    "dateStart" TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "dateUpd" TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "CareerTimeline_pkey" PRIMARY KEY ("idCareerTimeline")
);

-- CreateTable
CREATE TABLE "EducationalProject" (
    "idEducationalProject" SERIAL NOT NULL,
    "idPerson" INTEGER NOT NULL,
    "project" VARCHAR(45) NOT NULL,
    "description" TEXT NOT NULL,
    "url" VARCHAR(255),
    "dateStart" TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "dateUpd" TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "EducationalProject_pkey" PRIMARY KEY ("idEducationalProject")
);

-- CreateTable
CREATE TABLE "LanguageProfile" (
    "idLanguageProfile" SERIAL NOT NULL,
    "idPerson" INTEGER NOT NULL,
    "language" VARCHAR(45) NOT NULL,
    "level" VARCHAR(45) NOT NULL,
    "dateStart" TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "dateUpd" TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "LanguageProfile_pkey" PRIMARY KEY ("idLanguageProfile")
);

-- CreateTable
CREATE TABLE "Person" (
    "idPerson" INTEGER NOT NULL,
    "idUser" INTEGER NOT NULL,
    "name" VARCHAR(45) NOT NULL,
    "lastName" VARCHAR(45) NOT NULL,
    "birth" DATE NOT NULL,
    "cell" VARCHAR(45) NOT NULL,
    "country" VARCHAR(45) NOT NULL,
    "motivation" VARCHAR(2000),
    "dateStart" TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "dateUpd" TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Person_pkey" PRIMARY KEY ("idPerson")
);

-- CreateTable
CREATE TABLE "Session" (
    "idSession" BIGSERIAL NOT NULL,
    "idUser" INTEGER NOT NULL,
    "sessionToken" VARCHAR(255) NOT NULL,
    "expires" TIMESTAMP(0) NOT NULL,
    "dateStart" TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "dateUpd" TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Session_pkey" PRIMARY KEY ("idSession")
);

-- CreateTable
CREATE TABLE "TecnologieProfile" (
    "idTecnologieProfile" SERIAL NOT NULL,
    "idPerson" INTEGER NOT NULL,
    "tecnologie" VARCHAR(45) NOT NULL,
    "description" TEXT NOT NULL,
    "dateStart" TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "dateEnd" TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "TecnologieProfile_pkey" PRIMARY KEY ("idTecnologieProfile")
);

-- CreateTable
CREATE TABLE "User" (
    "idUser" SERIAL NOT NULL,
    "email" VARCHAR(255) NOT NULL,
    "alias" VARCHAR(15),
    "password" VARCHAR(120),
    "emailVerified" TIMESTAMP(0) NOT NULL,
    "image" VARCHAR(600),
    "dateStart" TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "dateUpd" TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "User_pkey" PRIMARY KEY ("idUser")
);

-- CreateTable
CREATE TABLE "VerificationToken" (
    "idVerificationToken" BIGSERIAL NOT NULL,
    "idUser" INTEGER NOT NULL,
    "token" VARCHAR(255) NOT NULL,
    "expires" TIMESTAMP(0) NOT NULL,
    "dateStart" TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "dateUpd" TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "VerificationToken_pkey" PRIMARY KEY ("idVerificationToken")
);

-- CreateIndex
CREATE INDEX "fk_Account_AuthProvider_idx" ON "Account"("keyAuthProvider");

-- CreateIndex
CREATE INDEX "fk_Account_User1_idx" ON "Account"("idUser");

-- CreateIndex
CREATE INDEX "fk_CareerTimeline_Person1_idx" ON "CareerTimeline"("idPerson");

-- CreateIndex
CREATE INDEX "fk_EducationalProject_Person10_idx" ON "EducationalProject"("idPerson");

-- CreateIndex
CREATE INDEX "fk_LanguageProfile_Person1_idx" ON "LanguageProfile"("idPerson");

-- CreateIndex
CREATE INDEX "fk_Person_User1_idx" ON "Person"("idUser");

-- CreateIndex
CREATE UNIQUE INDEX "sessionToken_UNIQUE" ON "Session"("sessionToken");

-- CreateIndex
CREATE INDEX "fk_Session_User1_idx" ON "Session"("idUser");

-- CreateIndex
CREATE INDEX "fk_TecnologieProfile_Person1_idx" ON "TecnologieProfile"("idPerson");

-- CreateIndex
CREATE UNIQUE INDEX "email_UNIQUE" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "token_UNIQUE" ON "VerificationToken"("token");

-- CreateIndex
CREATE INDEX "fk_VerificationToken_User1_idx" ON "VerificationToken"("idUser");

-- AddForeignKey
ALTER TABLE "Account" ADD CONSTRAINT "fk_Account_AuthProvider" FOREIGN KEY ("keyAuthProvider") REFERENCES "AuthProvider"("keyAuthProvider") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "Account" ADD CONSTRAINT "fk_Account_User1" FOREIGN KEY ("idUser") REFERENCES "User"("idUser") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "CareerTimeline" ADD CONSTRAINT "fk_CareerTimeline_Person1" FOREIGN KEY ("idPerson") REFERENCES "Person"("idPerson") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "EducationalProject" ADD CONSTRAINT "fk_EducationalProject_Person10" FOREIGN KEY ("idPerson") REFERENCES "Person"("idPerson") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "LanguageProfile" ADD CONSTRAINT "fk_LanguageProfile_Person1" FOREIGN KEY ("idPerson") REFERENCES "Person"("idPerson") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "Person" ADD CONSTRAINT "fk_Person_User1" FOREIGN KEY ("idUser") REFERENCES "User"("idUser") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "Session" ADD CONSTRAINT "fk_Session_User1" FOREIGN KEY ("idUser") REFERENCES "User"("idUser") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "TecnologieProfile" ADD CONSTRAINT "fk_TecnologieProfile_Person1" FOREIGN KEY ("idPerson") REFERENCES "Person"("idPerson") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "VerificationToken" ADD CONSTRAINT "fk_VerificationToken_User1" FOREIGN KEY ("idUser") REFERENCES "User"("idUser") ON DELETE NO ACTION ON UPDATE NO ACTION;
