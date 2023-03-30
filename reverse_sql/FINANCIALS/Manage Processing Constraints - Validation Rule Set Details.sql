/* ****************************************************************************
 * $Revision: 60928 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2017-02-06 17:14:01 +0700 (Mon, 06 Feb 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Assign%20Legal%20Entities%20-%20Assign%20Legal%20Entities.sql $:
 * $Id: Assign Legal Entities - Assign Legal Entities.sql 60928 2017-02-06 10:14:01Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT DOO.DISPLAY_NAME RES_NAME
,(SELECT DESCRIPTION
	FROM DOO_OBJECT_ATTRIBUTES_VL
	WHERE ENTITY_ID = DOO.ENTITY_ID
	AND MODULE_ID = DOO.MODULE_ID
	AND CONSTRAINT_CONDN_REF_FLAG = 'Y'
	AND NVL(EFF_CONTEXT_CODE,'X') = NVL(ValidationTemplateColumnEO.EFF_CONTEXT_CODE,'X')
	AND COLUMN_NAME = ValidationTemplateColumnEO.COLUMN_NAME
	) RES_ATTRIBUTE_NAME
,DECODE(ValidationTemplateColumnEO.VALIDATION_OP
	,'IS NOT NULL','Is not null'
	,'IS NULL','Is null'
	,(SELECT MEANING
		FROM FND_LOOKUPS LookupPEO
		WHERE LOOKUP_TYPE = 'DOO_PC_VALIDATION_OP'
		AND LOOKUP_CODE = ValidationTemplateColumnEO.VALIDATION_OP)
	) RES_VALIDATION_OPERATION
,(CASE
	WHEN ValidationTemplateColumnEO.COLUMN_NAME = 'ORG_ID' THEN
		(SELECT BU_NAME
			FROM FUN_ALL_BUSINESS_UNITS_V
			WHERE BU_ID = ValidationTemplateColumnEO.VALUE_STRING)
	WHEN ValidationTemplateColumnEO.COLUMN_NAME = 'BILL_TO_CUSTOMER_ID' OR ValidationTemplateColumnEO.COLUMN_NAME = 'SHIP_TO_CUSTOMER_ID' THEN
		(SELECT PARTY_NAME
			FROM HZ_PARTIES PartyE0
			,HZ_CUST_ACCOUNTS CusE0
			WHERE CusE0.PARTY_ID = PartyE0.PARTY_ID 
			AND CusE0.CUST_ACCOUNT_ID = ValidationTemplateColumnEO.VALUE_STRING)
	WHEN ValidationTemplateColumnEO.COLUMN_NAME LIKE '%FLAG' THEN
		DECODE(ValidationTemplateColumnEO.VALUE_STRING,'Y','Yes','N','No')
	ELSE
		ValidationTemplateColumnEO.VALUE_STRING
	END ) RES_VALUE_STRING	
,'' RES_ACCOUNT_NUMBER
,'' RES_CUSTOMER_REGISTRY_ID
,DOO.API_PKG RES_LABEL_NAME
,DOO.API_PROC RES_PLSQL_PROCEDURE
,NVL(ValidationTemplateColumnEO.LAST_UPDATED_BY,DOO.LAST_UPDATED_BY)  RSC_LAST_UPDATED_BY
,NVL(ValidationTemplateColumnEO.LAST_UPDATE_DATE,DOO.LAST_UPDATE_DATE)  RSC_LAST_UPDATE_DATE
,NVL(ValidationTemplateColumnEO.CREATED_BY,DOO.CREATED_BY)  RSC_CREATED_BY
,NVL(ValidationTemplateColumnEO.CREATION_DATE,DOO.CREATION_DATE)  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM DOO_PC_VTMPLTS_VL DOO
,DOO_PC_VTMPLT_COLS ValidationTemplateColumnEO
WHERE DOO.VALIDATION_TMPLT_ID = ValidationTemplateColumnEO.VALIDATION_TMPLT_ID(+)
AND (DOO.API_PKG IS NOT NULL
OR ValidationTemplateColumnEO.COLUMN_NAME IS NOT NULL)
ORDER BY 1,2