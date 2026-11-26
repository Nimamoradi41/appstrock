import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image/image.dart' as image;
import 'package:image_picker/image_picker.dart';

import '../../../../core/AppConfig.dart';
import '../../data/resident_patient_repository.dart';

class PatientImageUploadScreen extends StatefulWidget {
  const PatientImageUploadScreen({
    super.key,
    required this.name,
    required this.age,
    required this.nationalCode,
    required this.gender,
    required this.patientId,
    this.pickImage,
    this.uploadImage,
  });

  final String name, age, nationalCode, gender, patientId;
  final Future<XFile?> Function()? pickImage;
  final Future<PatientOperationResult> Function(
      String, Uint8List, String, MediaType)? uploadImage;

  @override
  State<PatientImageUploadScreen> createState() =>
      _PatientImageUploadScreenState();
}

class _PatientImageUploadScreenState extends State<PatientImageUploadScreen> {
  static const _maxBytes = 15 * 1024 * 1024;
  final _repository = ResidentPatientRepository();
  Uint8List? _bytes;
  String? _filename;
  MediaType? _contentType;
  String? _error;
  bool _selecting = false;
  bool _uploading = false;
  bool _uploaded = false;

  Future<void> _pick() async {
    if (_selecting || _uploading) return;
    setState(() {
      _selecting = true;
      _error = null;
    });
    try {
      final file = await (widget.pickImage?.call() ??
          ImagePicker().pickImage(source: ImageSource.gallery));
      if (file == null) return;
      if (await file.length() > _maxBytes) {
        if (mounted) {
          setState(() => _error = 'حجم تصویر باید کمتر از ۱۵ مگابایت باشد.');
        }
        return;
      }
      final bytes = await file.readAsBytes();
      if (bytes.length > _maxBytes || bytes.isEmpty) {
        if (mounted) setState(() => _error = 'حجم یا محتوای تصویر معتبر نیست.');
        return;
      }
      image.Decoder? decoded;
      try {
        decoded = image.findDecoderForData(bytes);
      } catch (_) {
        decoded = null;
      }
      final MediaType? type;
      final String extension;
      if (decoded is image.JpegDecoder) {
        type = MediaType('image', 'jpeg');
        extension = 'jpg';
      } else if (decoded is image.PngDecoder) {
        type = MediaType('image', 'png');
        extension = 'png';
      } else if (decoded is image.WebPDecoder) {
        type = MediaType('image', 'webp');
        extension = 'webp';
      } else {
        if (mounted) {
          setState(() =>
              _error = 'تصویر معتبر با فرمت JPG، PNG یا WebP انتخاب کنید.');
        }
        return;
      }
      if (decoded!.decode(bytes) == null) {
        if (mounted) {
          setState(
              () => _error = 'خواندن تصویر ممکن نیست؛ فایل دیگری انتخاب کنید.');
        }
        return;
      }
      if (!mounted) return;
      setState(() {
        _bytes = bytes;
        _filename =
            'patient_${DateTime.now().millisecondsSinceEpoch}.$extension';
        _contentType = type;
        _uploaded = false;
      });
    } catch (_) {
      if (mounted) {
        setState(() => _error = 'انتخاب تصویر ناموفق بود؛ دوباره تلاش کنید.');
      }
    } finally {
      if (mounted) setState(() => _selecting = false);
    }
  }

  Future<void> _upload() async {
    if (_bytes == null ||
        _filename == null ||
        _contentType == null ||
        _uploading ||
        _selecting ||
        _uploaded) {
      return;
    }
    setState(() {
      _uploading = true;
      _error = null;
    });
    try {
      final upload = widget.uploadImage ?? _repository.uploadImage;
      final result =
          await upload(widget.patientId, _bytes!, _filename!, _contentType!);
      if (!mounted) return;
      setState(() {
        if (result.success) {
          _uploaded = true;
        } else {
          _error = result.message.isEmpty
              ? 'ارسال تصویر ناموفق بود؛ دوباره تلاش کنید.'
              : result.message;
        }
      });
    } catch (_) {
      if (mounted) {
        setState(() => _error = 'ارسال تصویر ناموفق بود؛ دوباره تلاش کنید.');
      }
    } finally {
      if (mounted) setState(() => _uploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final busy = _selecting || _uploading;
    return PopScope(
        canPop: !busy,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
              backgroundColor: const Color(0xffeaf0f7),
              body: SafeArea(
                  child: Center(
                      child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 480),
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                                color: const Color(0xfffbfcfe),
                                borderRadius: BorderRadius.circular(24),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Color(0x220f2943),
                                      blurRadius: 14,
                                      offset: Offset(0, 5))
                                ]),
                            child: Column(children: [
                              Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(12, 8, 12, 0),
                                  child: Row(children: [
                                    IconButton(
                                        onPressed: busy
                                            ? null
                                            : () => Navigator.pop(
                                                context, _uploaded),
                                        tooltip: 'بازگشت',
                                        icon: const Icon(Icons.arrow_forward)),
                                    const Expanded(
                                        child: Text('بارگذاری تصویر',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: AppConfig
                                                    .inkColorResident))),
                                  ])),
                              const Divider(height: 1),
                              Expanded(
                                  child: SingleChildScrollView(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Container(
                                                padding:
                                                    const EdgeInsets.all(14),
                                                decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xffe8f6f1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    border: Border.all(
                                                        color: const Color(
                                                            0xffc5e8db))),
                                                child: Row(children: [
                                                  Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      decoration: BoxDecoration(
                                                          color: const Color(
                                                              0xffd5f0e6),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: const Icon(
                                                          Icons.person_outline,
                                                          color: AppConfig
                                                              .tealColorResident)),
                                                  const SizedBox(width: 12),
                                                  Expanded(
                                                      child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                        Text(
                                                            widget.name
                                                                    .trim()
                                                                    .isEmpty
                                                                ? 'نام ثبت نشده'
                                                                : widget.name,
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 16,
                                                                color: AppConfig
                                                                    .inkColorResident)),
                                                        const SizedBox(
                                                            height: 4),
                                                        Text(
                                                            '${widget.gender.trim().isEmpty ? '—' : widget.gender} · ${widget.age.trim().isEmpty ? '—' : AppConfig.digits(widget.age)} سال',
                                                            style: const TextStyle(
                                                                color: Color(
                                                                    0xff526073),
                                                                fontSize: 12)),
                                                        Text(
                                                            'کد ملی: ${widget.nationalCode.trim().isEmpty ? '—' : AppConfig.digits(widget.nationalCode)}',
                                                            style: const TextStyle(
                                                                color: Color(
                                                                    0xff526073),
                                                                fontSize: 12)),
                                                      ]))
                                                ])),
                                            const SizedBox(height: 20),
                                            const Text('تصویر پرونده بیمار',
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppConfig
                                                        .inkColorResident)),
                                            const SizedBox(height: 5),
                                            const Text(
                                                'تصویر موردنظر را انتخاب و پیش از ارسال بررسی کنید.',
                                                style: TextStyle(
                                                    color: Color(0xff526073),
                                                    fontSize: 12)),
                                            const SizedBox(height: 12),
                                            Container(
                                                height: 260,
                                                clipBehavior: Clip.antiAlias,
                                                decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xfff2f7fa),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            14),
                                                    border: Border.all(
                                                        color: const Color(
                                                            0xffc8d9e1))),
                                                child: _bytes == null
                                                    ? Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                            Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        15),
                                                                decoration: BoxDecoration(
                                                                    color: const Color(
                                                                        0xffdef3ed),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            18)),
                                                                child: const Icon(
                                                                    Icons
                                                                        .add_photo_alternate_outlined,
                                                                    size: 36,
                                                                    color: AppConfig
                                                                        .tealColorResident)),
                                                            const SizedBox(
                                                                height: 12),
                                                            const Text(
                                                                'هنوز تصویری انتخاب نشده است',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: AppConfig
                                                                        .inkColorResident)),
                                                            const SizedBox(
                                                                height: 5),
                                                            const Text(
                                                                'JPG، PNG یا WebP · حداکثر ۱۵ مگابایت',
                                                                textDirection:
                                                                    TextDirection
                                                                        .rtl,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        11,
                                                                    color: Color(
                                                                        0xff68788a))),
                                                          ])
                                                    : Image.memory(_bytes!,
                                                        fit: BoxFit.contain,
                                                        errorBuilder: (_, __,
                                                                ___) =>
                                                            const Center(
                                                                child: Text(
                                                                    'نمایش تصویر ممکن نیست')))),
                                            const SizedBox(height: 10),
                                            OutlinedButton.icon(
                                                onPressed: busy ? null : _pick,
                                                icon: const Icon(Icons
                                                    .photo_library_outlined),
                                                label: Text(_bytes == null
                                                    ? 'انتخاب تصویر'
                                                    : 'انتخاب تصویر دیگر'),
                                                style: OutlinedButton.styleFrom(
                                                    foregroundColor: AppConfig
                                                        .tealColorResident,
                                                    minimumSize:
                                                        const Size(0, 48))),
                                            if (_error != null)
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 12),
                                                  child: Text(_error!,
                                                      style: const TextStyle(
                                                          color:
                                                              Color(0xffb3261e),
                                                          fontSize: 13))),
                                            if (_uploaded)
                                              Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 12),
                                                  padding:
                                                      const EdgeInsets.all(12),
                                                  decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xffe0f5e8),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: const Row(children: [
                                                    Icon(
                                                        Icons
                                                            .check_circle_outline,
                                                        color:
                                                            Color(0xff168251)),
                                                    SizedBox(width: 8),
                                                    Expanded(
                                                        child: Text(
                                                            'تصویر با موفقیت در پرونده ثبت شد.',
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xff126b44),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 12)))
                                                  ])),
                                            const SizedBox(height: 16),
                                            Container(
                                                padding:
                                                    const EdgeInsets.all(12),
                                                decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xffe9f2fb),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: const Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Icon(Icons.info_outline,
                                                          color:
                                                              Color(0xff2059a2),
                                                          size: 20),
                                                      SizedBox(width: 8),
                                                      Expanded(
                                                          child: Text(
                                                              'پیش از ارسال، مطمئن شوید تصویر به همین بیمار مربوط است.',
                                                              style: TextStyle(
                                                                  color: AppConfig
                                                                      .inkColorResident,
                                                                  fontSize:
                                                                      12)))
                                                    ])),
                                          ]))),
                              Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 8, 16, 16),
                                  child: SizedBox(
                                      width: double.infinity,
                                      height: 48,
                                      child: FilledButton.icon(
                                          key: const ValueKey('upload-image-button'),
                                          onPressed: busy ||
                                                  _bytes == null ||
                                                  _uploaded
                                              ? null
                                              : _upload,
                                          style: FilledButton.styleFrom(
                                              backgroundColor:
                                                  AppConfig.tealColorResident),
                                          icon: _uploading
                                              ? const SizedBox(
                                                  width: 18,
                                                  height: 18,
                                                  child:
                                                      CircularProgressIndicator(
                                                          strokeWidth: 2,
                                                          color: Colors.white))
                                              : const Icon(
                                                  Icons.cloud_upload_outlined),
                                          label: Text(
                                              _uploading
                                                  ? 'در حال ارسال...'
                                                  : _uploaded
                                                      ? 'تصویر ارسال شد'
                                                      : 'ارسال تصویر به پرونده',
                                              style: const TextStyle(
                                                  fontWeight:
                                                      FontWeight.bold))))),
                            ]),
                          ))))),
        ));
  }
}
