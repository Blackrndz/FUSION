/* ****************************************************************************
 * $Revision: 73970 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2020-04-15 21:09:13 +0700 (Wed, 15 Apr 2020) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13.20/trunk/core/reverse_sql/FINANCIALS/Manage%20Positions%20-%20Position%20-%20DFF.sql $:
 * $Id: Manage Positions - Position - DFF.sql 73970 2020-04-15 14:09:13Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=800##RES##PER_POSITIONS_DFF
-- DFF_ATTRIBUTES=ATTRIBUTE,ATTRIBUTE_NUMBER,ATTRIBUTE_DATE

SELECT TO_CHAR(hrALLPOSTIONEO.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,(SELECT BU_NAME
	FROM FUN_ALL_BUSINESS_UNITS_V
	WHERE BU_ID = hrALLPOSTIONEO.BUSINESS_UNIT_ID 
	) RES_BUSINESS_UNIT
,hrALLPOSTIONEO.NAME RES_NAME
,hrALLPOSTIONEO.POSITION_CODE RES_CODE
,hrALLPOSTIONEO.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,hrALLPOSTIONEO.ATTRIBUTE1 
,hrALLPOSTIONEO.ATTRIBUTE2
,hrALLPOSTIONEO.ATTRIBUTE3 
,hrALLPOSTIONEO.ATTRIBUTE4 
,hrALLPOSTIONEO.ATTRIBUTE5 
,hrALLPOSTIONEO.ATTRIBUTE6 
,hrALLPOSTIONEO.ATTRIBUTE7 
,hrALLPOSTIONEO.ATTRIBUTE8 
,hrALLPOSTIONEO.ATTRIBUTE9 
,hrALLPOSTIONEO.ATTRIBUTE10 
,hrALLPOSTIONEO.ATTRIBUTE11
,hrALLPOSTIONEO.ATTRIBUTE12 
,hrALLPOSTIONEO.ATTRIBUTE13
,hrALLPOSTIONEO.ATTRIBUTE14 
,hrALLPOSTIONEO.ATTRIBUTE15 
,hrALLPOSTIONEO.ATTRIBUTE16 
,hrALLPOSTIONEO.ATTRIBUTE17 
,hrALLPOSTIONEO.ATTRIBUTE18 
,hrALLPOSTIONEO.ATTRIBUTE19 
,hrALLPOSTIONEO.ATTRIBUTE20
,hrALLPOSTIONEO.ATTRIBUTE21
,hrALLPOSTIONEO.ATTRIBUTE22
,hrALLPOSTIONEO.ATTRIBUTE23
,hrALLPOSTIONEO.ATTRIBUTE24
,hrALLPOSTIONEO.ATTRIBUTE25
,hrALLPOSTIONEO.ATTRIBUTE26
,hrALLPOSTIONEO.ATTRIBUTE27
,hrALLPOSTIONEO.ATTRIBUTE28
,hrALLPOSTIONEO.ATTRIBUTE29
,hrALLPOSTIONEO.ATTRIBUTE30
,hrALLPOSTIONEO.ATTRIBUTE_NUMBER1
,hrALLPOSTIONEO.ATTRIBUTE_NUMBER2
,hrALLPOSTIONEO.ATTRIBUTE_NUMBER3
,hrALLPOSTIONEO.ATTRIBUTE_NUMBER4
,hrALLPOSTIONEO.ATTRIBUTE_NUMBER5
,hrALLPOSTIONEO.ATTRIBUTE_NUMBER6
,hrALLPOSTIONEO.ATTRIBUTE_NUMBER7
,hrALLPOSTIONEO.ATTRIBUTE_NUMBER8
,hrALLPOSTIONEO.ATTRIBUTE_NUMBER9
,hrALLPOSTIONEO.ATTRIBUTE_NUMBER10
,hrALLPOSTIONEO.ATTRIBUTE_NUMBER11
,hrALLPOSTIONEO.ATTRIBUTE_NUMBER12
,hrALLPOSTIONEO.ATTRIBUTE_NUMBER13
,hrALLPOSTIONEO.ATTRIBUTE_NUMBER14
,hrALLPOSTIONEO.ATTRIBUTE_NUMBER15
,hrALLPOSTIONEO.ATTRIBUTE_NUMBER16
,hrALLPOSTIONEO.ATTRIBUTE_NUMBER17
,hrALLPOSTIONEO.ATTRIBUTE_NUMBER18
,hrALLPOSTIONEO.ATTRIBUTE_NUMBER19
,hrALLPOSTIONEO.ATTRIBUTE_NUMBER20
,TO_CHAR(hrALLPOSTIONEO.ATTRIBUTE_DATE1,'DD-Mon-YYYY') ATTRIBUTE_DATE1
,TO_CHAR(hrALLPOSTIONEO.ATTRIBUTE_DATE2,'DD-Mon-YYYY') ATTRIBUTE_DATE2
,TO_CHAR(hrALLPOSTIONEO.ATTRIBUTE_DATE3,'DD-Mon-YYYY') ATTRIBUTE_DATE3
,TO_CHAR(hrALLPOSTIONEO.ATTRIBUTE_DATE4,'DD-Mon-YYYY') ATTRIBUTE_DATE4
,TO_CHAR(hrALLPOSTIONEO.ATTRIBUTE_DATE5,'DD-Mon-YYYY') ATTRIBUTE_DATE5
,TO_CHAR(hrALLPOSTIONEO.ATTRIBUTE_DATE6,'DD-Mon-YYYY') ATTRIBUTE_DATE6
,TO_CHAR(hrALLPOSTIONEO.ATTRIBUTE_DATE7,'DD-Mon-YYYY') ATTRIBUTE_DATE7
,TO_CHAR(hrALLPOSTIONEO.ATTRIBUTE_DATE8,'DD-Mon-YYYY') ATTRIBUTE_DATE8
,TO_CHAR(hrALLPOSTIONEO.ATTRIBUTE_DATE9,'DD-Mon-YYYY') ATTRIBUTE_DATE9
,TO_CHAR(hrALLPOSTIONEO.ATTRIBUTE_DATE10,'DD-Mon-YYYY') ATTRIBUTE_DATE10
,TO_CHAR(hrALLPOSTIONEO.ATTRIBUTE_DATE11,'DD-Mon-YYYY') ATTRIBUTE_DATE11
,TO_CHAR(hrALLPOSTIONEO.ATTRIBUTE_DATE12,'DD-Mon-YYYY') ATTRIBUTE_DATE12
,TO_CHAR(hrALLPOSTIONEO.ATTRIBUTE_DATE13,'DD-Mon-YYYY') ATTRIBUTE_DATE13
,TO_CHAR(hrALLPOSTIONEO.ATTRIBUTE_DATE14,'DD-Mon-YYYY') ATTRIBUTE_DATE14
,TO_CHAR(hrALLPOSTIONEO.ATTRIBUTE_DATE15,'DD-Mon-YYYY') ATTRIBUTE_DATE15

,hrALLPOSTIONEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,hrALLPOSTIONEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,hrALLPOSTIONEO.CREATED_BY RSC_CREATED_BY
,hrALLPOSTIONEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HR_ALL_POSITIONS_F_VL hrALLPOSTIONEO
WHERE (hrALLPOSTIONEO.ATTRIBUTE_CATEGORY IS NOT NULL OR
hrALLPOSTIONEO.ATTRIBUTE1 IS NOT NULL OR
hrALLPOSTIONEO.ATTRIBUTE2 IS NOT NULL OR
hrALLPOSTIONEO.ATTRIBUTE3 IS NOT NULL OR 
hrALLPOSTIONEO.ATTRIBUTE4 IS NOT NULL OR 
hrALLPOSTIONEO.ATTRIBUTE5 IS NOT NULL OR 
hrALLPOSTIONEO.ATTRIBUTE6 IS NOT NULL OR 
hrALLPOSTIONEO.ATTRIBUTE7 IS NOT NULL OR 
hrALLPOSTIONEO.ATTRIBUTE8 IS NOT NULL OR 
hrALLPOSTIONEO.ATTRIBUTE9 IS NOT NULL OR 
hrALLPOSTIONEO.ATTRIBUTE10 IS NOT NULL OR 
hrALLPOSTIONEO.ATTRIBUTE11 IS NOT NULL OR 
hrALLPOSTIONEO.ATTRIBUTE12 IS NOT NULL OR 
hrALLPOSTIONEO.ATTRIBUTE13 IS NOT NULL OR 
hrALLPOSTIONEO.ATTRIBUTE14 IS NOT NULL OR 
hrALLPOSTIONEO.ATTRIBUTE15 IS NOT NULL OR 
hrALLPOSTIONEO.ATTRIBUTE16 IS NOT NULL OR 
hrALLPOSTIONEO.ATTRIBUTE17 IS NOT NULL OR 
hrALLPOSTIONEO.ATTRIBUTE18 IS NOT NULL OR 
hrALLPOSTIONEO.ATTRIBUTE19 IS NOT NULL OR 
hrALLPOSTIONEO.ATTRIBUTE20 IS NOT NULL OR 
hrALLPOSTIONEO.ATTRIBUTE21 IS NOT NULL OR 
hrALLPOSTIONEO.ATTRIBUTE22 IS NOT NULL OR 
hrALLPOSTIONEO.ATTRIBUTE23 IS NOT NULL OR 
hrALLPOSTIONEO.ATTRIBUTE24 IS NOT NULL OR 
hrALLPOSTIONEO.ATTRIBUTE25 IS NOT NULL OR 
hrALLPOSTIONEO.ATTRIBUTE26 IS NOT NULL OR 
hrALLPOSTIONEO.ATTRIBUTE27 IS NOT NULL OR 
hrALLPOSTIONEO.ATTRIBUTE28 IS NOT NULL OR 
hrALLPOSTIONEO.ATTRIBUTE29 IS NOT NULL OR 
hrALLPOSTIONEO.ATTRIBUTE30 IS NOT NULL OR 
hrALLPOSTIONEO.ATTRIBUTE_NUMBER1 IS NOT NULL OR 
hrALLPOSTIONEO.ATTRIBUTE_NUMBER2 IS NOT NULL OR 
hrALLPOSTIONEO.ATTRIBUTE_NUMBER3 IS NOT NULL OR 
hrALLPOSTIONEO.ATTRIBUTE_NUMBER4 IS NOT NULL OR 
hrALLPOSTIONEO.ATTRIBUTE_NUMBER5 IS NOT NULL OR 
hrALLPOSTIONEO.ATTRIBUTE_NUMBER6 IS NOT NULL OR 
hrALLPOSTIONEO.ATTRIBUTE_NUMBER7 IS NOT NULL OR 
hrALLPOSTIONEO.ATTRIBUTE_NUMBER8 IS NOT NULL OR 
hrALLPOSTIONEO.ATTRIBUTE_NUMBER9 IS NOT NULL OR 
hrALLPOSTIONEO.ATTRIBUTE_NUMBER10 IS NOT NULL OR 
hrALLPOSTIONEO.ATTRIBUTE_NUMBER11 IS NOT NULL OR 
hrALLPOSTIONEO.ATTRIBUTE_NUMBER12 IS NOT NULL OR 
hrALLPOSTIONEO.ATTRIBUTE_NUMBER13 IS NOT NULL OR 
hrALLPOSTIONEO.ATTRIBUTE_NUMBER14 IS NOT NULL OR 
hrALLPOSTIONEO.ATTRIBUTE_NUMBER15 IS NOT NULL OR 
hrALLPOSTIONEO.ATTRIBUTE_NUMBER16 IS NOT NULL OR 
hrALLPOSTIONEO.ATTRIBUTE_NUMBER17 IS NOT NULL OR 
hrALLPOSTIONEO.ATTRIBUTE_NUMBER18 IS NOT NULL OR 
hrALLPOSTIONEO.ATTRIBUTE_NUMBER19 IS NOT NULL OR 
hrALLPOSTIONEO.ATTRIBUTE_NUMBER20 IS NOT NULL OR 
hrALLPOSTIONEO.ATTRIBUTE_DATE1 IS NOT NULL OR
hrALLPOSTIONEO.ATTRIBUTE_DATE2 IS NOT NULL OR 
hrALLPOSTIONEO.ATTRIBUTE_DATE3 IS NOT NULL OR 
hrALLPOSTIONEO.ATTRIBUTE_DATE4 IS NOT NULL OR 
hrALLPOSTIONEO.ATTRIBUTE_DATE5 IS NOT NULL OR 
hrALLPOSTIONEO.ATTRIBUTE_DATE6 IS NOT NULL OR 
hrALLPOSTIONEO.ATTRIBUTE_DATE7 IS NOT NULL OR 
hrALLPOSTIONEO.ATTRIBUTE_DATE8 IS NOT NULL OR 
hrALLPOSTIONEO.ATTRIBUTE_DATE9 IS NOT NULL OR 
hrALLPOSTIONEO.ATTRIBUTE_DATE10 IS NOT NULL OR 
hrALLPOSTIONEO.ATTRIBUTE_DATE11 IS NOT NULL OR 
hrALLPOSTIONEO.ATTRIBUTE_DATE12 IS NOT NULL OR 
hrALLPOSTIONEO.ATTRIBUTE_DATE13 IS NOT NULL OR 
hrALLPOSTIONEO.ATTRIBUTE_DATE14 IS NOT NULL OR 
hrALLPOSTIONEO.ATTRIBUTE_DATE15 IS NOT NULL  
)
ORDER BY hrALLPOSTIONEO.NAME
,hrALLPOSTIONEO.POSITION_CODE
,hrALLPOSTIONEO.EFFECTIVE_START_DATE