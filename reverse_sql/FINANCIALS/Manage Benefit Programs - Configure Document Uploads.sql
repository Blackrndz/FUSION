/* ****************************************************************************
 * $Revision: 78239 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 22:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Benefit%20Programs%20-%20Configure%20Document%20Uploads.sql $:
 * $Id: Manage Benefit Programs - Configure Document Uploads.sql 78239 2022-04-07 15:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
--RSC_PREREQUISITE_OBJECTS=BEN_CTFN_DOC_MAP

SELECT benPGMEO.NAME RES_PROGRAM_NAME 
,TO_CHAR(benPGMEO.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'ORA_BEN_DOC_CTFN_TYP'
    AND LOOKUP_CODE = benCTFNDOCMAPE0.CTFN_TYPE_CD 
    ) RES_CERTIFICATION_TYPE
,(SELECT DOCUMENT_TYPE FROM HR_DOCUMENT_TYPES_VL WHERE DOCUMENT_TYPE_ID = benCTFNDOCMAPE0.DOCUMENT_TYPE_ID) RES_DOCUMENT_TYPE
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'ORA_BEN_DOC_VALIDITY'
    AND LOOKUP_CODE = benCTFNDOCMAPE0.VALIDITY_CD 
    ) RES_VALIDITY_RULE
,benCTFNDOCMAPE0.VALIDITY_TM_NUM RES_NUMBER_OF_DAYS
,TO_CHAR(benCTFNDOCMAPE0.START_DATE,'DD-Mon-YYYY') RES_DOCUMENT_UPLOADS_START_DAT
,TO_CHAR(benCTFNDOCMAPE0.END_DATE,'DD-Mon-YYYY') RES_DOCUMENT_UPLOADS_END_DATE

,benCTFNDOCMAPE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,benCTFNDOCMAPE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,benCTFNDOCMAPE0.CREATED_BY RSC_CREATED_BY
,benCTFNDOCMAPE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,benPGMEO.LEGISLATION_CODE RSC_COUNTRY_ID

FROM BEN_PGM_F benPGMEO
,BEN_CTFN_DOC_MAP benCTFNDOCMAPE0
WHERE benPGMEO.PGM_ID = benCTFNDOCMAPE0.MAPPING_TABLE_PK_ID
AND benCTFNDOCMAPE0.MAPPING_TABLE_NAME = 'BEN_PGM_F'
AND benCTFNDOCMAPE0.MAPPING_COLUMN_NAME = 'PGM_ID'
AND SYSDATE BETWEEN benPGMEO.EFFECTIVE_START_DATE AND NVL(benPGMEO.EFFECTIVE_END_DATE,TO_DATE('31-12-4712','DD-MM-YYYY'))
AND SYSDATE BETWEEN benCTFNDOCMAPE0.START_DATE AND NVL(benCTFNDOCMAPE0.END_DATE,TO_DATE('31-12-4712','DD-MM-YYYY'))
ORDER BY RES_PROGRAM_NAME,RES_CERTIFICATION_TYPE
