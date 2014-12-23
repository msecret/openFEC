
  UPDATE public.dimcmte AS p
  SET    expire_date = o.expire_date
  FROM   frn.dimcmte AS o
  WHERE  p.cmte_sk = o.cmte_sk
  AND    p.expire_date IS NULL
  AND    o.expire_date IS NOT NULL;
  

  UPDATE public.dimcandoffice AS p
  SET    expire_date = o.expire_date
  FROM   frn.dimcandoffice AS o
  WHERE  p.candoffice_sk = o.candoffice_sk
  AND    p.expire_date IS NULL
  AND    o.expire_date IS NOT NULL;
  

  UPDATE public.dimcmteproperties AS p
  SET    expire_date = o.expire_date
  FROM   frn.dimcmteproperties AS o
  WHERE  p.cmteproperties_sk = o.cmteproperties_sk
  AND    p.expire_date IS NULL
  AND    o.expire_date IS NOT NULL;
  

  UPDATE public.dimcand AS p
  SET    expire_date = o.expire_date
  FROM   frn.dimcand AS o
  WHERE  p.cand_sk = o.cand_sk
  AND    p.expire_date IS NULL
  AND    o.expire_date IS NOT NULL;
  

  UPDATE public.dimcandstatusici AS p
  SET    expire_date = o.expire_date
  FROM   frn.dimcandstatusici AS o
  WHERE  p.candstatusici_sk = o.candstatusici_sk
  AND    p.expire_date IS NULL
  AND    o.expire_date IS NOT NULL;
  

  UPDATE public.dimcmtetpdsgn AS p
  SET    expire_date = o.expire_date
  FROM   frn.dimcmtetpdsgn AS o
  WHERE  p.cmte_tpdgn_sk = o.cmte_tpdgn_sk
  AND    p.expire_date IS NULL
  AND    o.expire_date IS NOT NULL;
  

  UPDATE public.dimelectiontp AS p
  SET    expire_date = o.expire_date
  FROM   frn.dimelectiontp AS o
  WHERE  p.electiontp_sk = o.electiontp_sk
  AND    p.expire_date IS NULL
  AND    o.expire_date IS NOT NULL;
  

  UPDATE public.dimlinkages AS p
  SET    expire_date = o.expire_date
  FROM   frn.dimlinkages AS o
  WHERE  p.linkages_sk = o.linkages_sk
  AND    p.expire_date IS NULL
  AND    o.expire_date IS NOT NULL;
  

  UPDATE public.dimoffice AS p
  SET    expire_date = o.expire_date
  FROM   frn.dimoffice AS o
  WHERE  p.office_sk = o.office_sk
  AND    p.expire_date IS NULL
  AND    o.expire_date IS NOT NULL;
  

  UPDATE public.dimparty AS p
  SET    expire_date = o.expire_date
  FROM   frn.dimparty AS o
  WHERE  p.party_sk = o.party_sk
  AND    p.expire_date IS NULL
  AND    o.expire_date IS NOT NULL;
  

  UPDATE public.dimreporttype AS p
  SET    expire_date = o.expire_date
  FROM   frn.dimreporttype AS o
  WHERE  p.reporttype_sk = o.reporttype_sk
  AND    p.expire_date IS NULL
  AND    o.expire_date IS NOT NULL;
  

  UPDATE public.facthousesenate_f3 AS p
  SET    expire_date = o.expire_date
  FROM   frn.facthousesenate_f3 AS o
  WHERE  p.facthousesenate_f3_sk = o.facthousesenate_f3_sk
  AND    p.expire_date IS NULL
  AND    o.expire_date IS NOT NULL;
  

  UPDATE public.factpacsandparties_f3x AS p
  SET    expire_date = o.expire_date
  FROM   frn.factpacsandparties_f3x AS o
  WHERE  p.factpacsandparties_f3x_sk = o.factpacsandparties_f3x_sk
  AND    p.expire_date IS NULL
  AND    o.expire_date IS NOT NULL;
  

  UPDATE public.factpresidential_f3p AS p
  SET    expire_date = o.expire_date
  FROM   frn.factpresidential_f3p AS o
  WHERE  p.factpresidential_f3p_sk = o.factpresidential_f3p_sk
  AND    p.expire_date IS NULL
  AND    o.expire_date IS NOT NULL;
  

  UPDATE public.dimcandproperties AS p
  SET    expire_date = o.expire_date
  FROM   frn.dimcandproperties AS o
  WHERE  p.candproperties_sk = o.candproperties_sk
  AND    p.expire_date IS NULL
  AND    o.expire_date IS NOT NULL;
  

  WITH missing AS (
    SELECT sched_a_sk FROM frn.sched_a
    EXCEPT ALL
    SELECT sched_a_sk FROM public.sched_a )
  INSERT INTO public.sched_a
  SELECT f.*
  FROM   frn.sched_a f
  JOIN   missing ON (f.sched_a_sk = missing.sched_a_sk);
  

  WITH missing AS (
    SELECT cmte_sk FROM frn.dimcmte
    EXCEPT ALL
    SELECT cmte_sk FROM public.dimcmte )
  INSERT INTO public.dimcmte
  SELECT f.*
  FROM   frn.dimcmte f
  JOIN   missing ON (f.cmte_sk = missing.cmte_sk);
  

  WITH missing AS (
    SELECT sched_b_sk FROM frn.sched_b
    EXCEPT ALL
    SELECT sched_b_sk FROM public.sched_b )
  INSERT INTO public.sched_b
  SELECT f.*
  FROM   frn.sched_b f
  JOIN   missing ON (f.sched_b_sk = missing.sched_b_sk);
  

  WITH missing AS (
    SELECT cand_ici_cd FROM processed_fec.ref_cand_ici
    EXCEPT ALL
    SELECT cand_ici_cd FROM processed.ref_cand_ici )
  INSERT INTO processed.ref_cand_ici
  SELECT f.*
  FROM   processed_fec.ref_cand_ici f
  JOIN   missing ON (f.cand_ici_cd = missing.cand_ici_cd);
  

  WITH missing AS (
    SELECT cand_status_cd FROM processed_fec.ref_cand_status
    EXCEPT ALL
    SELECT cand_status_cd FROM processed.ref_cand_status )
  INSERT INTO processed.ref_cand_status
  SELECT f.*
  FROM   processed_fec.ref_cand_status f
  JOIN   missing ON (f.cand_status_cd = missing.cand_status_cd);
  

  WITH missing AS (
    SELECT cand_status_ici_sk FROM processed_fec.cand_status_ici
    EXCEPT ALL
    SELECT cand_status_ici_sk FROM processed.cand_status_ici )
  INSERT INTO processed.cand_status_ici
  SELECT f.*
  FROM   processed_fec.cand_status_ici f
  JOIN   missing ON (f.cand_status_ici_sk = missing.cand_status_ici_sk);
  

  WITH missing AS (
    SELECT cmte_dsgn FROM processed_fec.ref_cmte_dsgn
    EXCEPT ALL
    SELECT cmte_dsgn FROM processed.ref_cmte_dsgn )
  INSERT INTO processed.ref_cmte_dsgn
  SELECT f.*
  FROM   processed_fec.ref_cmte_dsgn f
  JOIN   missing ON (f.cmte_dsgn = missing.cmte_dsgn);
  

  WITH missing AS (
    SELECT cmte_tp FROM processed_fec.ref_cmte_type
    EXCEPT ALL
    SELECT cmte_tp FROM processed.ref_cmte_type )
  INSERT INTO processed.ref_cmte_type
  SELECT f.*
  FROM   processed_fec.ref_cmte_type f
  JOIN   missing ON (f.cmte_tp = missing.cmte_tp);
  

  WITH missing AS (
    SELECT election_tp FROM processed_fec.ref_election
    EXCEPT ALL
    SELECT election_tp FROM processed.ref_election )
  INSERT INTO processed.ref_election
  SELECT f.*
  FROM   processed_fec.ref_election f
  JOIN   missing ON (f.election_tp = missing.election_tp);
  

  WITH missing AS (
    SELECT entity_tp FROM processed_fec.ref_entity_type
    EXCEPT ALL
    SELECT entity_tp FROM processed.ref_entity_type )
  INSERT INTO processed.ref_entity_type
  SELECT f.*
  FROM   processed_fec.ref_entity_type f
  JOIN   missing ON (f.entity_tp = missing.entity_tp);
  

  WITH missing AS (
    SELECT form_10_sk FROM processed_fec.form_10
    EXCEPT ALL
    SELECT form_10_sk FROM processed.form_10 )
  INSERT INTO processed.form_10
  SELECT f.*
  FROM   processed_fec.form_10 f
  JOIN   missing ON (f.form_10_sk = missing.form_10_sk);
  

  WITH missing AS (
    SELECT form_11_sk FROM processed_fec.form_11
    EXCEPT ALL
    SELECT form_11_sk FROM processed.form_11 )
  INSERT INTO processed.form_11
  SELECT f.*
  FROM   processed_fec.form_11 f
  JOIN   missing ON (f.form_11_sk = missing.form_11_sk);
  

  WITH missing AS (
    SELECT form_12_sk FROM processed_fec.form_12
    EXCEPT ALL
    SELECT form_12_sk FROM processed.form_12 )
  INSERT INTO processed.form_12
  SELECT f.*
  FROM   processed_fec.form_12 f
  JOIN   missing ON (f.form_12_sk = missing.form_12_sk);
  

  WITH missing AS (
    SELECT form_13_sk FROM processed_fec.form_13
    EXCEPT ALL
    SELECT form_13_sk FROM processed.form_13 )
  INSERT INTO processed.form_13
  SELECT f.*
  FROM   processed_fec.form_13 f
  JOIN   missing ON (f.form_13_sk = missing.form_13_sk);
  

  WITH missing AS (
    SELECT form_1_sk FROM processed_fec.form_1
    EXCEPT ALL
    SELECT form_1_sk FROM processed.form_1 )
  INSERT INTO processed.form_1
  SELECT f.*
  FROM   processed_fec.form_1 f
  JOIN   missing ON (f.form_1_sk = missing.form_1_sk);
  

  WITH missing AS (
    SELECT form_1m_sk FROM processed_fec.form_1m
    EXCEPT ALL
    SELECT form_1m_sk FROM processed.form_1m )
  INSERT INTO processed.form_1m
  SELECT f.*
  FROM   processed_fec.form_1m f
  JOIN   missing ON (f.form_1m_sk = missing.form_1m_sk);
  

  WITH missing AS (
    SELECT form_1s_sk FROM processed_fec.form_1s
    EXCEPT ALL
    SELECT form_1s_sk FROM processed.form_1s )
  INSERT INTO processed.form_1s
  SELECT f.*
  FROM   processed_fec.form_1s f
  JOIN   missing ON (f.form_1s_sk = missing.form_1s_sk);
  

  WITH missing AS (
    SELECT form_24_sk FROM processed_fec.form_24
    EXCEPT ALL
    SELECT form_24_sk FROM processed.form_24 )
  INSERT INTO processed.form_24
  SELECT f.*
  FROM   processed_fec.form_24 f
  JOIN   missing ON (f.form_24_sk = missing.form_24_sk);
  

  WITH missing AS (
    SELECT form_2_sk FROM processed_fec.form_2
    EXCEPT ALL
    SELECT form_2_sk FROM processed.form_2 )
  INSERT INTO processed.form_2
  SELECT f.*
  FROM   processed_fec.form_2 f
  JOIN   missing ON (f.form_2_sk = missing.form_2_sk);
  

  WITH missing AS (
    SELECT form_2s_sk FROM processed_fec.form_2s
    EXCEPT ALL
    SELECT form_2s_sk FROM processed.form_2s )
  INSERT INTO processed.form_2s
  SELECT f.*
  FROM   processed_fec.form_2s f
  JOIN   missing ON (f.form_2s_sk = missing.form_2s_sk);
  

  WITH missing AS (
    SELECT form_3_sk FROM processed_fec.form_3
    EXCEPT ALL
    SELECT form_3_sk FROM processed.form_3 )
  INSERT INTO processed.form_3
  SELECT f.*
  FROM   processed_fec.form_3 f
  JOIN   missing ON (f.form_3_sk = missing.form_3_sk);
  

  WITH missing AS (
    SELECT form_3l_sk FROM processed_fec.form_3l
    EXCEPT ALL
    SELECT form_3l_sk FROM processed.form_3l )
  INSERT INTO processed.form_3l
  SELECT f.*
  FROM   processed_fec.form_3l f
  JOIN   missing ON (f.form_3l_sk = missing.form_3l_sk);
  

  WITH missing AS (
    SELECT form_3p31s_sk FROM processed_fec.form_3p_line_31s
    EXCEPT ALL
    SELECT form_3p31s_sk FROM processed.form_3p_line_31s )
  INSERT INTO processed.form_3p_line_31s
  SELECT f.*
  FROM   processed_fec.form_3p_line_31s f
  JOIN   missing ON (f.form_3p31s_sk = missing.form_3p31s_sk);
  

  WITH missing AS (
    SELECT form_3p_sk FROM processed_fec.form_3p
    EXCEPT ALL
    SELECT form_3p_sk FROM processed.form_3p )
  INSERT INTO processed.form_3p
  SELECT f.*
  FROM   processed_fec.form_3p f
  JOIN   missing ON (f.form_3p_sk = missing.form_3p_sk);
  

  WITH missing AS (
    SELECT form_3ps_sk FROM processed_fec.form_3ps
    EXCEPT ALL
    SELECT form_3ps_sk FROM processed.form_3ps )
  INSERT INTO processed.form_3ps
  SELECT f.*
  FROM   processed_fec.form_3ps f
  JOIN   missing ON (f.form_3ps_sk = missing.form_3ps_sk);
  

  WITH missing AS (
    SELECT form_3s_sk FROM processed_fec.form_3s
    EXCEPT ALL
    SELECT form_3s_sk FROM processed.form_3s )
  INSERT INTO processed.form_3s
  SELECT f.*
  FROM   processed_fec.form_3s f
  JOIN   missing ON (f.form_3s_sk = missing.form_3s_sk);
  

  WITH missing AS (
    SELECT form_3x_sk FROM processed_fec.form_3x
    EXCEPT ALL
    SELECT form_3x_sk FROM processed.form_3x )
  INSERT INTO processed.form_3x
  SELECT f.*
  FROM   processed_fec.form_3x f
  JOIN   missing ON (f.form_3x_sk = missing.form_3x_sk);
  

  WITH missing AS (
    SELECT form_3z_sk FROM processed_fec.form_3z
    EXCEPT ALL
    SELECT form_3z_sk FROM processed.form_3z )
  INSERT INTO processed.form_3z
  SELECT f.*
  FROM   processed_fec.form_3z f
  JOIN   missing ON (f.form_3z_sk = missing.form_3z_sk);
  

  WITH missing AS (
    SELECT form_4_sk FROM processed_fec.form_4
    EXCEPT ALL
    SELECT form_4_sk FROM processed.form_4 )
  INSERT INTO processed.form_4
  SELECT f.*
  FROM   processed_fec.form_4 f
  JOIN   missing ON (f.form_4_sk = missing.form_4_sk);
  

  WITH missing AS (
    SELECT form_5_sk FROM processed_fec.form_5
    EXCEPT ALL
    SELECT form_5_sk FROM processed.form_5 )
  INSERT INTO processed.form_5
  SELECT f.*
  FROM   processed_fec.form_5 f
  JOIN   missing ON (f.form_5_sk = missing.form_5_sk);
  

  WITH missing AS (
    SELECT form_6_sk FROM processed_fec.form_6
    EXCEPT ALL
    SELECT form_6_sk FROM processed.form_6 )
  INSERT INTO processed.form_6
  SELECT f.*
  FROM   processed_fec.form_6 f
  JOIN   missing ON (f.form_6_sk = missing.form_6_sk);
  

  WITH missing AS (
    SELECT form_7_sk FROM processed_fec.form_7
    EXCEPT ALL
    SELECT form_7_sk FROM processed.form_7 )
  INSERT INTO processed.form_7
  SELECT f.*
  FROM   processed_fec.form_7 f
  JOIN   missing ON (f.form_7_sk = missing.form_7_sk);
  

  WITH missing AS (
    SELECT form_8_sk FROM processed_fec.form_8
    EXCEPT ALL
    SELECT form_8_sk FROM processed.form_8 )
  INSERT INTO processed.form_8
  SELECT f.*
  FROM   processed_fec.form_8 f
  JOIN   missing ON (f.form_8_sk = missing.form_8_sk);
  

  WITH missing AS (
    SELECT form_99_misc_sk FROM processed_fec.form_99_misc
    EXCEPT ALL
    SELECT form_99_misc_sk FROM processed.form_99_misc )
  INSERT INTO processed.form_99_misc
  SELECT f.*
  FROM   processed_fec.form_99_misc f
  JOIN   missing ON (f.form_99_misc_sk = missing.form_99_misc_sk);
  

  WITH missing AS (
    SELECT form_9_sk FROM processed_fec.form_9
    EXCEPT ALL
    SELECT form_9_sk FROM processed.form_9 )
  INSERT INTO processed.form_9
  SELECT f.*
  FROM   processed_fec.form_9 f
  JOIN   missing ON (f.form_9_sk = missing.form_9_sk);
  

  WITH missing AS (
    SELECT form_tp FROM processed_fec.ref_form_type
    EXCEPT ALL
    SELECT form_tp FROM processed.ref_form_type )
  INSERT INTO processed.ref_form_type
  SELECT f.*
  FROM   processed_fec.ref_form_type f
  JOIN   missing ON (f.form_tp = missing.form_tp);
  

  WITH missing AS (
    SELECT office_tp FROM processed_fec.ref_office
    EXCEPT ALL
    SELECT office_tp FROM processed.ref_office )
  INSERT INTO processed.ref_office
  SELECT f.*
  FROM   processed_fec.ref_office f
  JOIN   missing ON (f.office_tp = missing.office_tp);
  

  WITH missing AS (
    SELECT org_tp FROM processed_fec.ref_org_type
    EXCEPT ALL
    SELECT org_tp FROM processed.ref_org_type )
  INSERT INTO processed.ref_org_type
  SELECT f.*
  FROM   processed_fec.ref_org_type f
  JOIN   missing ON (f.org_tp = missing.org_tp);
  

  WITH missing AS (
    SELECT party_cd FROM processed_fec.ref_party
    EXCEPT ALL
    SELECT party_cd FROM processed.ref_party )
  INSERT INTO processed.ref_party
  SELECT f.*
  FROM   processed_fec.ref_party f
  JOIN   missing ON (f.party_cd = missing.party_cd);
  

  WITH missing AS (
    SELECT rpt_tp FROM processed_fec.ref_report_type
    EXCEPT ALL
    SELECT rpt_tp FROM processed.ref_report_type )
  INSERT INTO processed.ref_report_type
  SELECT f.*
  FROM   processed_fec.ref_report_type f
  JOIN   missing ON (f.rpt_tp = missing.rpt_tp);
  

  WITH missing AS (
    SELECT state_cd FROM processed_fec.ref_state
    EXCEPT ALL
    SELECT state_cd FROM processed.ref_state )
  INSERT INTO processed.ref_state
  SELECT f.*
  FROM   processed_fec.ref_state f
  JOIN   missing ON (f.state_cd = missing.state_cd);
  

  WITH missing AS (
    SELECT transaction_cd FROM processed_fec.ref_transaction_code
    EXCEPT ALL
    SELECT transaction_cd FROM processed.ref_transaction_code )
  INSERT INTO processed.ref_transaction_code
  SELECT f.*
  FROM   processed_fec.ref_transaction_code f
  JOIN   missing ON (f.transaction_cd = missing.transaction_cd);
  

  WITH missing AS (
    SELECT candoffice_sk FROM frn.dimcandoffice
    EXCEPT ALL
    SELECT candoffice_sk FROM public.dimcandoffice )
  INSERT INTO public.dimcandoffice
  SELECT f.*
  FROM   frn.dimcandoffice f
  JOIN   missing ON (f.candoffice_sk = missing.candoffice_sk);
  

  WITH missing AS (
    SELECT cmteproperties_sk FROM frn.dimcmteproperties
    EXCEPT ALL
    SELECT cmteproperties_sk FROM public.dimcmteproperties )
  INSERT INTO public.dimcmteproperties
  SELECT f.*
  FROM   frn.dimcmteproperties f
  JOIN   missing ON (f.cmteproperties_sk = missing.cmteproperties_sk);
  

  WITH missing AS (
    SELECT cand_sk FROM frn.dimcand
    EXCEPT ALL
    SELECT cand_sk FROM public.dimcand )
  INSERT INTO public.dimcand
  SELECT f.*
  FROM   frn.dimcand f
  JOIN   missing ON (f.cand_sk = missing.cand_sk);
  

  WITH missing AS (
    SELECT candstatusici_sk FROM frn.dimcandstatusici
    EXCEPT ALL
    SELECT candstatusici_sk FROM public.dimcandstatusici )
  INSERT INTO public.dimcandstatusici
  SELECT f.*
  FROM   frn.dimcandstatusici f
  JOIN   missing ON (f.candstatusici_sk = missing.candstatusici_sk);
  

  WITH missing AS (
    SELECT cmte_tpdgn_sk FROM frn.dimcmtetpdsgn
    EXCEPT ALL
    SELECT cmte_tpdgn_sk FROM public.dimcmtetpdsgn )
  INSERT INTO public.dimcmtetpdsgn
  SELECT f.*
  FROM   frn.dimcmtetpdsgn f
  JOIN   missing ON (f.cmte_tpdgn_sk = missing.cmte_tpdgn_sk);
  

  WITH missing AS (
    SELECT date_sk FROM frn.dimdates
    EXCEPT ALL
    SELECT date_sk FROM public.dimdates )
  INSERT INTO public.dimdates
  SELECT f.*
  FROM   frn.dimdates f
  JOIN   missing ON (f.date_sk = missing.date_sk);
  

  WITH missing AS (
    SELECT electiontp_sk FROM frn.dimelectiontp
    EXCEPT ALL
    SELECT electiontp_sk FROM public.dimelectiontp )
  INSERT INTO public.dimelectiontp
  SELECT f.*
  FROM   frn.dimelectiontp f
  JOIN   missing ON (f.electiontp_sk = missing.electiontp_sk);
  

  WITH missing AS (
    SELECT linkages_sk FROM frn.dimlinkages
    EXCEPT ALL
    SELECT linkages_sk FROM public.dimlinkages )
  INSERT INTO public.dimlinkages
  SELECT f.*
  FROM   frn.dimlinkages f
  JOIN   missing ON (f.linkages_sk = missing.linkages_sk);
  

  WITH missing AS (
    SELECT office_sk FROM frn.dimoffice
    EXCEPT ALL
    SELECT office_sk FROM public.dimoffice )
  INSERT INTO public.dimoffice
  SELECT f.*
  FROM   frn.dimoffice f
  JOIN   missing ON (f.office_sk = missing.office_sk);
  

  WITH missing AS (
    SELECT party_sk FROM frn.dimparty
    EXCEPT ALL
    SELECT party_sk FROM public.dimparty )
  INSERT INTO public.dimparty
  SELECT f.*
  FROM   frn.dimparty f
  JOIN   missing ON (f.party_sk = missing.party_sk);
  

  WITH missing AS (
    SELECT reporttype_sk FROM frn.dimreporttype
    EXCEPT ALL
    SELECT reporttype_sk FROM public.dimreporttype )
  INSERT INTO public.dimreporttype
  SELECT f.*
  FROM   frn.dimreporttype f
  JOIN   missing ON (f.reporttype_sk = missing.reporttype_sk);
  

  WITH missing AS (
    SELECT year_sk FROM frn.dimyears
    EXCEPT ALL
    SELECT year_sk FROM public.dimyears )
  INSERT INTO public.dimyears
  SELECT f.*
  FROM   frn.dimyears f
  JOIN   missing ON (f.year_sk = missing.year_sk);
  

  WITH missing AS (
    SELECT facthousesenate_f3_sk FROM frn.facthousesenate_f3
    EXCEPT ALL
    SELECT facthousesenate_f3_sk FROM public.facthousesenate_f3 )
  INSERT INTO public.facthousesenate_f3
  SELECT f.*
  FROM   frn.facthousesenate_f3 f
  JOIN   missing ON (f.facthousesenate_f3_sk = missing.facthousesenate_f3_sk);
  

  WITH missing AS (
    SELECT factpacsandparties_f3x_sk FROM frn.factpacsandparties_f3x
    EXCEPT ALL
    SELECT factpacsandparties_f3x_sk FROM public.factpacsandparties_f3x )
  INSERT INTO public.factpacsandparties_f3x
  SELECT f.*
  FROM   frn.factpacsandparties_f3x f
  JOIN   missing ON (f.factpacsandparties_f3x_sk = missing.factpacsandparties_f3x_sk);
  

  WITH missing AS (
    SELECT factpresidential_f3p_sk FROM frn.factpresidential_f3p
    EXCEPT ALL
    SELECT factpresidential_f3p_sk FROM public.factpresidential_f3p )
  INSERT INTO public.factpresidential_f3p
  SELECT f.*
  FROM   frn.factpresidential_f3p f
  JOIN   missing ON (f.factpresidential_f3p_sk = missing.factpresidential_f3p_sk);
  

  WITH missing AS (
    SELECT form_105_sk FROM frn.form_105
    EXCEPT ALL
    SELECT form_105_sk FROM public.form_105 )
  INSERT INTO public.form_105
  SELECT f.*
  FROM   frn.form_105 f
  JOIN   missing ON (f.form_105_sk = missing.form_105_sk);
  

  WITH missing AS (
    SELECT form_56_sk FROM frn.form_56
    EXCEPT ALL
    SELECT form_56_sk FROM public.form_56 )
  INSERT INTO public.form_56
  SELECT f.*
  FROM   frn.form_56 f
  JOIN   missing ON (f.form_56_sk = missing.form_56_sk);
  

  WITH missing AS (
    SELECT form_57_sk FROM frn.form_57
    EXCEPT ALL
    SELECT form_57_sk FROM public.form_57 )
  INSERT INTO public.form_57
  SELECT f.*
  FROM   frn.form_57 f
  JOIN   missing ON (f.form_57_sk = missing.form_57_sk);
  

  WITH missing AS (
    SELECT form_65_sk FROM frn.form_65
    EXCEPT ALL
    SELECT form_65_sk FROM public.form_65 )
  INSERT INTO public.form_65
  SELECT f.*
  FROM   frn.form_65 f
  JOIN   missing ON (f.form_65_sk = missing.form_65_sk);
  

  WITH missing AS (
    SELECT form_76_sk FROM frn.form_76
    EXCEPT ALL
    SELECT form_76_sk FROM public.form_76 )
  INSERT INTO public.form_76
  SELECT f.*
  FROM   frn.form_76 f
  JOIN   missing ON (f.form_76_sk = missing.form_76_sk);
  

  WITH missing AS (
    SELECT form_82_sk FROM frn.form_82
    EXCEPT ALL
    SELECT form_82_sk FROM public.form_82 )
  INSERT INTO public.form_82
  SELECT f.*
  FROM   frn.form_82 f
  JOIN   missing ON (f.form_82_sk = missing.form_82_sk);
  

  WITH missing AS (
    SELECT form_83_sk FROM frn.form_83
    EXCEPT ALL
    SELECT form_83_sk FROM public.form_83 )
  INSERT INTO public.form_83
  SELECT f.*
  FROM   frn.form_83 f
  JOIN   missing ON (f.form_83_sk = missing.form_83_sk);
  

  WITH missing AS (
    SELECT form_91_sk FROM frn.form_91
    EXCEPT ALL
    SELECT form_91_sk FROM public.form_91 )
  INSERT INTO public.form_91
  SELECT f.*
  FROM   frn.form_91 f
  JOIN   missing ON (f.form_91_sk = missing.form_91_sk);
  

  WITH missing AS (
    SELECT form_94_sk FROM frn.form_94
    EXCEPT ALL
    SELECT form_94_sk FROM public.form_94 )
  INSERT INTO public.form_94
  SELECT f.*
  FROM   frn.form_94 f
  JOIN   missing ON (f.form_94_sk = missing.form_94_sk);
  

  WITH missing AS (
    SELECT dml_id FROM frn.log_audit_dml
    EXCEPT ALL
    SELECT dml_id FROM public.log_audit_dml )
  INSERT INTO public.log_audit_dml
  SELECT f.*
  FROM   frn.log_audit_dml f
  JOIN   missing ON (f.dml_id = missing.dml_id);
  

  WITH missing AS (
    SELECT audit_id FROM frn.log_audit_module
    EXCEPT ALL
    SELECT audit_id FROM public.log_audit_module )
  INSERT INTO public.log_audit_module
  SELECT f.*
  FROM   frn.log_audit_module f
  JOIN   missing ON (f.audit_id = missing.audit_id);
  

  WITH missing AS (
    SELECT run_id FROM frn.log_audit_process
    EXCEPT ALL
    SELECT run_id FROM public.log_audit_process )
  INSERT INTO public.log_audit_process
  SELECT f.*
  FROM   frn.log_audit_process f
  JOIN   missing ON (f.run_id = missing.run_id);
  

  WITH missing AS (
    SELECT sched_c_sk FROM frn.sched_c
    EXCEPT ALL
    SELECT sched_c_sk FROM public.sched_c )
  INSERT INTO public.sched_c
  SELECT f.*
  FROM   frn.sched_c f
  JOIN   missing ON (f.sched_c_sk = missing.sched_c_sk);
  

  WITH missing AS (
    SELECT sched_c1_sk FROM frn.sched_c1
    EXCEPT ALL
    SELECT sched_c1_sk FROM public.sched_c1 )
  INSERT INTO public.sched_c1
  SELECT f.*
  FROM   frn.sched_c1 f
  JOIN   missing ON (f.sched_c1_sk = missing.sched_c1_sk);
  

  WITH missing AS (
    SELECT sched_c2_sk FROM frn.sched_c2
    EXCEPT ALL
    SELECT sched_c2_sk FROM public.sched_c2 )
  INSERT INTO public.sched_c2
  SELECT f.*
  FROM   frn.sched_c2 f
  JOIN   missing ON (f.sched_c2_sk = missing.sched_c2_sk);
  

  WITH missing AS (
    SELECT sched_d_sk FROM frn.sched_d
    EXCEPT ALL
    SELECT sched_d_sk FROM public.sched_d )
  INSERT INTO public.sched_d
  SELECT f.*
  FROM   frn.sched_d f
  JOIN   missing ON (f.sched_d_sk = missing.sched_d_sk);
  

  WITH missing AS (
    SELECT sched_e_sk FROM frn.sched_e
    EXCEPT ALL
    SELECT sched_e_sk FROM public.sched_e )
  INSERT INTO public.sched_e
  SELECT f.*
  FROM   frn.sched_e f
  JOIN   missing ON (f.sched_e_sk = missing.sched_e_sk);
  

  WITH missing AS (
    SELECT sched_f_sk FROM frn.sched_f
    EXCEPT ALL
    SELECT sched_f_sk FROM public.sched_f )
  INSERT INTO public.sched_f
  SELECT f.*
  FROM   frn.sched_f f
  JOIN   missing ON (f.sched_f_sk = missing.sched_f_sk);
  

  WITH missing AS (
    SELECT sched_h1_sk FROM frn.sched_h1
    EXCEPT ALL
    SELECT sched_h1_sk FROM public.sched_h1 )
  INSERT INTO public.sched_h1
  SELECT f.*
  FROM   frn.sched_h1 f
  JOIN   missing ON (f.sched_h1_sk = missing.sched_h1_sk);
  

  WITH missing AS (
    SELECT sched_h2_sk FROM frn.sched_h2
    EXCEPT ALL
    SELECT sched_h2_sk FROM public.sched_h2 )
  INSERT INTO public.sched_h2
  SELECT f.*
  FROM   frn.sched_h2 f
  JOIN   missing ON (f.sched_h2_sk = missing.sched_h2_sk);
  

  WITH missing AS (
    SELECT sched_h3_sk FROM frn.sched_h3
    EXCEPT ALL
    SELECT sched_h3_sk FROM public.sched_h3 )
  INSERT INTO public.sched_h3
  SELECT f.*
  FROM   frn.sched_h3 f
  JOIN   missing ON (f.sched_h3_sk = missing.sched_h3_sk);
  

  WITH missing AS (
    SELECT sched_h4_sk FROM frn.sched_h4
    EXCEPT ALL
    SELECT sched_h4_sk FROM public.sched_h4 )
  INSERT INTO public.sched_h4
  SELECT f.*
  FROM   frn.sched_h4 f
  JOIN   missing ON (f.sched_h4_sk = missing.sched_h4_sk);
  

  WITH missing AS (
    SELECT sched_h5_sk FROM frn.sched_h5
    EXCEPT ALL
    SELECT sched_h5_sk FROM public.sched_h5 )
  INSERT INTO public.sched_h5
  SELECT f.*
  FROM   frn.sched_h5 f
  JOIN   missing ON (f.sched_h5_sk = missing.sched_h5_sk);
  

  WITH missing AS (
    SELECT sched_h6_sk FROM frn.sched_h6
    EXCEPT ALL
    SELECT sched_h6_sk FROM public.sched_h6 )
  INSERT INTO public.sched_h6
  SELECT f.*
  FROM   frn.sched_h6 f
  JOIN   missing ON (f.sched_h6_sk = missing.sched_h6_sk);
  

  WITH missing AS (
    SELECT sched_i_sk FROM frn.sched_i
    EXCEPT ALL
    SELECT sched_i_sk FROM public.sched_i )
  INSERT INTO public.sched_i
  SELECT f.*
  FROM   frn.sched_i f
  JOIN   missing ON (f.sched_i_sk = missing.sched_i_sk);
  

  WITH missing AS (
    SELECT sched_l_sk FROM frn.sched_l
    EXCEPT ALL
    SELECT sched_l_sk FROM public.sched_l )
  INSERT INTO public.sched_l
  SELECT f.*
  FROM   frn.sched_l f
  JOIN   missing ON (f.sched_l_sk = missing.sched_l_sk);
  

  WITH missing AS (
    SELECT candproperties_sk FROM frn.dimcandproperties
    EXCEPT ALL
    SELECT candproperties_sk FROM public.dimcandproperties )
  INSERT INTO public.dimcandproperties
  SELECT f.*
  FROM   frn.dimcandproperties f
  JOIN   missing ON (f.candproperties_sk = missing.candproperties_sk);
  
