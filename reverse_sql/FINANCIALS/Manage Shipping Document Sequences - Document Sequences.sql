/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2017-04-25 $:
 * $HeadURL: $:
 * $Id: Manage Shipping Document Sequences - Document Sequences.sql  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 


SELECT QRSLT.NAME  RES_DOCUMENT_SEQUENCE_NAME
,QRSLT.APPLICATION_NAME RES_APPLICATION
,QRSLT.USER_MODULE_NAME RES_MODULE
,QRSLT.TYPE_MEANING RES_TYPE
,QRSLT.DETERMINANT_TYPE_MEANING RES_DETERMINANT_TYPE
,TO_CHAR(QRSLT.START_DATE,'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(QRSLT.END_DATE,'DD-Mon-YYYY') RES_END_DATE
,QRSLT.INITIAL_VALUE RES_INITIAL_VALUE
,DECODE(QRSLT.TRANSIENTAUDIT,'Y','Yes','No') RES_AUDIT
,DECODE(QRSLT.MESSAGE_FLAG,'Y','Yes','No') RES_DISPLAY_MESSAGE
,(CASE
	WHEN QRSLT.TYPE = 'G' THEN
		DECODE(QRSLT.VALIDATE_TRANSACTION_DATE,'Y','Yes','No')
	END) RES_VALIDATE_TRANSACTION_DATE
,QRSLT.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,QRSLT.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,QRSLT.CREATED_BY  RSC_CREATED_BY
,QRSLT.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,QRSLT.ENTERPRISE_ID RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM (
SELECT distinct DocumentSequencesEO.DOC_SEQUENCE_ID
,DocumentSequencesEO.NAME
,DOCUMENTSEQUENCESEO.APPLICATION_ID
,ApplicationPEO.APPLICATION_NAME
,DocumentSequencesEO.MODULE_ID
,DOCUMENTSEQUENCESEO.TYPE
,(SELECT MEANING
		FROM FND_LOOKUP_VALUES
		WHERE LOOKUP_type = 'FND_DOCUMENT_SEQUENCES_TYPE'
		AND lookup_code   = DOCUMENTSEQUENCESEO.TYPE
		AND LANGUAGE = USERENV('LANG')
		) TYPE_MEANING
,DOCUMENTSEQUENCESEO.DETERMINANT_TYPE
,(SELECT MEANING
		FROM FND_LOOKUP_VALUES
		WHERE LOOKUP_type = 'FND_DOC_SEQ_DETERMINANT_TYPE'
		AND lookup_code   = DOCUMENTSEQUENCESEO.DETERMINANT_TYPE
		AND LANGUAGE = USERENV('LANG')
		) DETERMINANT_TYPE_MEANING
,DocumentSequencesEO.START_DATE
,DocumentSequencesEO.END_DATE
,DocumentSequencesEO.TABLE_NAME
,DocumentSequencesEO.AUDIT_TABLE_NAME
,DocumentSequencesEO.DB_SEQUENCE_NAME
,DocumentSequencesEO.INITIAL_VALUE
,DocumentSequencesEO.MESSAGE_FLAG
,DocumentSequencesEO.LAST_UPDATE_DATE
,DocumentSequencesEO.LAST_UPDATED_BY
,DocumentSequencesEO.CREATED_BY
,DocumentSequencesEO.CREATION_DATE
,DocumentSequencesEO.ENTERPRISE_ID
,ApplTaxonomyPEO.MODULE_KEY
,ApplTaxonomyPEO.MODULE_ID AS MODULE_ID1
,ApplTaxonomyPEO.MODULE_TYPE
,ApplTaxonomyPEO.USER_MODULE_NAME
,(DECODE(AUDIT_TABLE_NAME,NULL,'N','Y')) AS TRANSIENTAUDIT
,DocumentSequencesEO.VALIDATE_TRANSACTION_DATE
FROM FND_DOCUMENT_SEQUENCES DOCUMENTSEQUENCESEO
,FND_APPL_TAXONOMY_VL APPLTAXONOMYPEO 
,FND_APPLICATION_VL APPLICATIONPEO
,FND_DOC_SEQUENCE_ASSIGNMENTS DocSequenceAssignmentsEO
WHERE DOCUMENTSEQUENCESEO.MODULE_ID = APPLTAXONOMYPEO.MODULE_ID
and   DOCUMENTSEQUENCESEO.APPLICATION_ID =     ApplicationPEO.APPLICATION_ID
AND(DocumentSequencesEO.MODULE_ID  IN
	(SELECT rf.child_module_id
	FROM fnd_appl_taxonomy_rf rf
	,fnd_appl_taxonomy at
	WHERE at.module_type = 'APPLICATION'
	AND at.module_key    = 'WSH'
	AND AT.MODULE_ID     = RF.ANCESTOR_MODULE_ID
	))
AND DOCUMENTSEQUENCESEO.DOC_SEQUENCE_ID        = DOCSEQUENCEASSIGNMENTSEO.DOC_SEQUENCE_ID(+)	
	) QRSLT
ORDER BY QRSLT.NAME